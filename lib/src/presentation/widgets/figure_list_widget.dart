import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class FigureListWidgetParams implements FigureListParams {
  /// ListBloc params
  final FigureListBloc? figureListBloc;

  FigureListWidgetParams(this.figureListBloc);
}

class FigureListBlocProvider extends StatelessWidget
    implements FigureListWidgetParams {
  /// FigureListWidgetParams
  @override
  final FigureListBloc? figureListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  /// Widget params
  final Widget child;

  const FigureListBlocProvider({
    super.key,

    /// FigureListWidgetParams
    this.figureListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,

    /// Widget params
    required this.child,
  }) : assert(figureListBloc == null ||
            (ofArtist == null && ofDance == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return (figureListBloc != null)
        ? BlocProvider<FigureListBloc>.value(
            value: figureListBloc!,
            child: child,
          )
        : BlocProvider<FigureListBloc>(
            create: (_) => FigureListBloc(
              figureRepository:
                  Provider.of<FigureRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(FigureListLoad(
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofVideo: ofVideo,
              )),
            child: child,
          );
  }
}

class FigureListView extends StatefulWidget implements FigureListWidgetParams {
  /// FigureListWidgetParams
  @override
  final FigureListBloc? figureListBloc;
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

    /// FigureListWidgetParams
    this.figureListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,

    /// ListView params
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(figureListBloc == null ||
            (ofArtist == null && ofDance == null && ofVideo == null));

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
    return FigureListBlocProvider(
      figureListBloc: widget.figureListBloc,
      ofArtist: widget.ofArtist,
      ofDance: widget.ofDance,
      ofVideo: widget.ofVideo,
      child: BlocBuilder<FigureListBloc, FigureListState>(
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
      ),
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

class FiguresSection extends StatelessWidget implements FigureListWidgetParams {
  /// FigureListWidgetParams
  @override
  final FigureListBloc? figureListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  const FiguresSection({
    super.key,

    /// FigureListWidgetParams
    this.figureListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
  }) : assert(figureListBloc == null ||
            (ofArtist == null && ofDance == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return FigureListBlocProvider(
      figureListBloc: figureListBloc,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofVideo: ofVideo,
      child: Builder(
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
      ),
    );
  }
}
