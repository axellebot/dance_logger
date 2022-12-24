import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class FigureListBlocParams implements FigureListParams {
  /// ListBloc params
  final FigureListBloc? figureListBloc;

  FigureListBlocParams(
    this.figureListBloc,
  );
}

class FigureListBlocProvider extends StatelessWidget
    implements FigureListBlocParams {
  /// FigureListBlocParams
  @override
  final FigureListBloc? figureListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  /// Selection
  final List<FigureViewModel>? preselectedFigures;

  /// Widget params
  final Widget child;

  const FigureListBlocProvider({
    super.key,

    /// FigureListBlocParams
    this.figureListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,

    /// Selection
    this.preselectedFigures,

    /// Widget params
    required this.child,
  }) : assert(figureListBloc == null ||
            (ofArtist == null && ofDance == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    if (figureListBloc != null) {
      return BlocProvider<FigureListBloc>.value(
        value: figureListBloc!,
        child: child,
      );
    } else {
      return BlocProvider<FigureListBloc>(
        create: (context) {
          final figureListBloc = FigureListBloc(
            figureRepository:
                Provider.of<FigureRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (preselectedFigures?.isNotEmpty ?? false) {
            figureListBloc.add(FigureListSelect(figures: preselectedFigures!));
          }

          figureListBloc.add(FigureListLoad(
            ofArtist: ofArtist,
            ofDance: ofDance,
            ofVideo: ofVideo,
          ));

          return figureListBloc;
        },
        child: child,
      );
    }
  }
}

class FigureListView extends StatefulWidget
    implements FigureListBlocParams, EntityListViewParams {
  /// FigureListWidgetParams
  @override
  final FigureListBloc? figureListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  /// EntityListViewParams
  @override
  final Axis scrollDirection;
  @override
  final ScrollPhysics? physics;
  @override
  final EdgeInsets? padding;

  /// Misc
  final ItemCallback<FigureViewModel>? onSelect;

  const FigureListView({
    super.key,

    /// FigureListWidgetParams
    this.figureListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,

    /// Misc
    this.onSelect,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(figureListBloc == null ||
            (ofArtist == null && ofDance == null && ofVideo == null));

  @override
  State<FigureListView> createState() => _FigureListViewState();
}

class _FigureListViewState extends State<FigureListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return FigureListBlocProvider(
      figureListBloc: widget.figureListBloc,
      ofArtist: widget.ofArtist,
      ofDance: widget.ofDance,
      ofVideo: widget.ofVideo,
      child: BlocListener<FigureListBloc, FigureListState>(
        listener: (context, FigureListState state) {
          switch (state.status) {
            case FigureListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadNoData();
              }
              break;
            case FigureListStatus.loadingFailure:
              _refreshController.loadFailed();
              break;
            case FigureListStatus.refreshingSuccess:
              _refreshController.refreshCompleted(resetFooterState: true);
              break;
            case FigureListStatus.refreshingFailure:
              _refreshController.refreshFailed();
              break;
            default:
          }
        },
        child: BlocBuilder<FigureListBloc, FigureListState>(
          builder: (context, FigureListState state) {
            final figureListBloc = BlocProvider.of<FigureListBloc>(context);

            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () {
                figureListBloc.add(const FigureListRefresh());
              },
              onLoading: () {
                figureListBloc.add(const FigureListLoadMore());
              },
              scrollDirection: widget.scrollDirection,
              child: ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                itemCount: state.figures.length,
                itemBuilder: (context, index) {
                  final FigureViewModel figure = state.figures[index];
                  final FigureListBloc artistListBloc =
                      BlocProvider.of<FigureListBloc>(context);
                  switch (widget.scrollDirection) {
                    case Axis.vertical:
                      if (state.selectedFigures.isEmpty) {
                        return FigureListTile(
                          figure: figure,
                          onTap: widget.onSelect,
                          onLongPress: (item) {
                            artistListBloc.add(
                              FigureListSelect(figures: [item]),
                            );
                          },
                        );
                      } else {
                        return CheckboxFigureListTile(
                          figure: figure,
                          value: state.selectedFigures
                              .any((element) => element.id == figure.id),
                          onChanged: (bool? value) {
                            artistListBloc.add(
                              (value == true)
                                  ? FigureListSelect(figures: [figure])
                                  : FigureListUnselect(figures: [figure]),
                            );
                          },
                        );
                      }
                    case Axis.horizontal:
                      return FigureCard(figure: figure);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class FiguresSection extends StatelessWidget
    implements FigureListBlocParams, EntitiesSectionWidgetParams {
  /// FigureListWidgetParams
  @override
  final FigureListBloc? figureListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onSectionTap;

  const FiguresSection({
    super.key,

    /// FigureListWidgetParams
    this.figureListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,
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
                leading: const Icon(Icons.sports_gymnastics),
                title: Text(label ?? "Figures"),
                onTap: onSectionTap ??
                    () {
                      AutoRouter.of(context).push(
                        FigureListRoute(
                          figureListBloc:
                              BlocProvider.of<FigureListBloc>(context),
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
