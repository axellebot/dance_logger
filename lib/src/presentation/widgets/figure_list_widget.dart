import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FigureListView extends StatefulWidget implements FigureListParams {
  /// ListBloc params
  final FigureListBloc? figureListBloc;

  /// FigureListParams
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  /// ListView params
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  const FigureListView({
    super.key,

    /// ListBloc params
    this.figureListBloc,

    /// ArtistListParams
    this.ofArtist,
    this.ofDance,
    this.ofVideo,

    /// ListView params
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
    final Widget mainContent = BlocBuilder<FigureListBloc, FigureListState>(
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
    return (widget.figureListBloc != null)
        ? BlocProvider<FigureListBloc>.value(
            value: widget.figureListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => FigureListBloc(
              figureRepository:
                  Provider.of<FigureRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(FigureListLoad(
                ofArtist: widget.ofArtist,
                ofDance: widget.ofDance,
                ofVideo: widget.ofVideo,
              )),
            child: mainContent,
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
  /// ListBloc params
  final FigureListBloc? figureListBloc;

  /// FigureListParams
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  const FiguresSection({
    super.key,

    /// ListBloc params
    this.figureListBloc,

    /// FigureListParams
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    final Widget mainContent = Builder(
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SectionTile(
              title: const Text('Figures'),
              onTap: () {
                AutoRouter.of(context).push(
                  FigureListRoute(
                    figureListBloc: BlocProvider.of<FigureListBloc>(context),
                  ),
                );
              },
            ),
            SizedBox(
              height: AppStyles.cardHeight,
              child: FigureListView(
                figureListBloc: BlocProvider.of<FigureListBloc>(context),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        );
      },
    );

    return (figureListBloc != null)
        ? BlocProvider<FigureListBloc>.value(
            value: figureListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => FigureListBloc(
              figureRepository:
                  Provider.of<FigureRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(FigureListLoad(
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofVideo: ofVideo,
              )),
            child: mainContent,
          );
  }
}
