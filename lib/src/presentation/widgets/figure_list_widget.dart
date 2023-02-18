import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

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
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofVideoId;

  /// Selection
  final List<FigureViewModel>? preselectedFigures;

  /// Widget params
  final Widget child;

  const FigureListBlocProvider({
    super.key,

    /// FigureListBlocParams
    this.figureListBloc,
    this.ofArtistId,
    this.ofDanceId,
    this.ofVideoId,

    /// Selection
    this.preselectedFigures,

    /// Widget params
    required this.child,
  }) : assert(figureListBloc == null ||
            (ofArtistId == null && ofDanceId == null && ofVideoId == null));

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
            ofArtistId: ofArtistId,
            ofDanceId: ofDanceId,
            ofVideoId: ofVideoId,
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
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofVideoId;

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
    this.ofArtistId,
    this.ofDanceId,
    this.ofVideoId,

    /// Misc
    this.onSelect,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(figureListBloc == null ||
            (ofArtistId == null && ofDanceId == null && ofVideoId == null));

  @override
  State<FigureListView> createState() => _FigureListViewState();
}

class _FigureListViewState extends State<FigureListView> {
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  Widget build(BuildContext context) {
    return FigureListBlocProvider(
      figureListBloc: widget.figureListBloc,
      ofArtistId: widget.ofArtistId,
      ofDanceId: widget.ofDanceId,
      ofVideoId: widget.ofVideoId,
      child: BlocListener<FigureListBloc, FigureListState>(
        listener: (context, FigureListState state) {
          switch (state.status) {
            case FigureListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.finishLoad();
              } else {
                _refreshController.finishLoad(IndicatorResult.noMore);
              }
              break;
            case FigureListStatus.loadingFailure:
              _refreshController.finishLoad(IndicatorResult.fail);
              break;
            case FigureListStatus.refreshingSuccess:
              _refreshController.finishRefresh(IndicatorResult.success);
              break;
            case FigureListStatus.refreshingFailure:
              _refreshController.finishRefresh(IndicatorResult.fail);
              break;
            default:
          }
        },
        child: BlocBuilder<FigureListBloc, FigureListState>(
          builder: (context, FigureListState state) {
            final figureListBloc = BlocProvider.of<FigureListBloc>(context);

            return EasyRefresh(
              controller: _refreshController,
              header: (widget.scrollDirection == Axis.horizontal)
                  ? const MaterialHeader()
                  : null,
              footer: (widget.scrollDirection == Axis.horizontal)
                  ? const MaterialFooter()
                  : null,
              onRefresh: () {
                figureListBloc.add(const FigureListRefresh());
              },
              onLoad: () {
                figureListBloc.add(const FigureListLoadMore());
              },
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

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }
}

class FiguresSection extends StatelessWidget
    implements FigureListBlocParams, EntitiesSectionWidgetParams {
  /// FigureListWidgetParams
  @override
  final FigureListBloc? figureListBloc;
  @override
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofVideoId;

  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onSectionTap;

  const FiguresSection({
    super.key,

    /// FigureListWidgetParams
    this.figureListBloc,
    this.ofArtistId,
    this.ofDanceId,
    this.ofVideoId,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,
  }) : assert(figureListBloc == null ||
            (ofArtistId == null && ofDanceId == null && ofVideoId == null));

  @override
  Widget build(BuildContext context) {
    return FigureListBlocProvider(
      figureListBloc: figureListBloc,
      ofArtistId: ofArtistId,
      ofDanceId: ofDanceId,
      ofVideoId: ofVideoId,
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
