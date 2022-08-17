import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureListView extends StatefulWidget {
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  const FigureListView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _FigureListViewState();
}

class _FigureListViewState extends State<FigureListView> {
  final _scrollController = ScrollController();

  _FigureListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FigureListBloc, FigureListState>(
      builder: (context, state) {
        switch (state.status) {
          case FigureListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
              physics: widget.physics,
              padding: widget.padding,
            );
          case FigureListStatus.failure:
          case FigureListStatus.success:
          case FigureListStatus.refreshing:
            if (state.figures.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                label: 'No Figures',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.figures.length
                    : state.figures.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.figures.length) {
                    final FigureViewModel figure = state.figures[index];
                    final FigureListBloc artistListBloc =
                        BlocProvider.of<FigureListBloc>(context);
                    switch (widget.scrollDirection) {
                      case Axis.vertical:
                        if (state.selectedFigures.isEmpty) {
                          return FigureListTile(
                            figure: figure,
                            onLongPress: () {
                              artistListBloc.add(
                                FigureListSelect(figureId: figure.id),
                              );
                            },
                          );
                        } else {
                          return CheckboxFigureListTile(
                            figure: figure,
                            value: state.selectedFigures.contains(figure.id),
                            onChanged: (bool? value) {
                              artistListBloc.add(
                                (value == true)
                                    ? FigureListSelect(figureId: figure.id)
                                    : FigureListUnselect(figureId: figure.id),
                              );
                            },
                          );
                        }
                      case Axis.horizontal:
                        return FigureCard(figure: figure);
                    }
                  } else {
                    switch (widget.scrollDirection) {
                      case Axis.vertical:
                        return const BottomListLoadingIndicator();
                      case Axis.horizontal:
                        return const RightListLoadingIndicator();
                    }
                  }
                },
              );
            }
          default:
            return ErrorListView(
              scrollDirection: widget.scrollDirection,
              padding: widget.padding,
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }

  void _onScroll() {
    if (_shouldLoadMore) {
      context.read<FigureListBloc>().add(const FigureListLoadMore());
    }
  }

  bool get _shouldLoadMore {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final scrollThreshold = (maxScroll * 0.9);
    final currentScroll = _scrollController.offset;
    return currentScroll >= scrollThreshold;
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}

class FiguresSection extends StatelessWidget implements FigureListParams {
  /// Figure list params
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  const FiguresSection({
    super.key,

    /// Figure list params
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FigureListBloc>(
      create: (context) => FigureListBloc(
        figureRepository: RepositoryProvider.of<FigureRepository>(context),
        mapper: ModelMapper(),
      )..add(FigureListLoad(
          ofArtist: ofArtist,
          ofDance: ofDance,
          ofVideo: ofVideo,
        )),
      child: Builder(builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SectionTile(
              title: const Text('Figures'),
              onTap: () {
                AutoRouter.of(context).push(
                  FigureListRoute(
                    ofArtist: ofArtist,
                    ofDance: ofDance,
                    ofVideo: ofVideo,
                    figureListBloc: BlocProvider.of<FigureListBloc>(context),
                  ),
                );
              },
            ),
            const SizedBox(
              height: AppStyles.cardHeight,
              child: FigureListView(
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        );
      }),
    );
  }
}
