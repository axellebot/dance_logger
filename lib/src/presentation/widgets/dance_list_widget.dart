import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

abstract class DanceListWidgetParams implements DanceListParams {
  /// ListBloc params
  final DanceListBloc? danceListBloc;

  DanceListWidgetParams(this.danceListBloc);
}

class DanceListBlocProvider extends StatelessWidget
    implements DanceListWidgetParams {
  /// DanceListWidgetParams
  @override
  final DanceListBloc? danceListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtistId;
  @override
  final String? ofVideoId;

  /// Selection
  final List<DanceViewModel>? preselectedDances;

  /// Widget params
  final Widget child;

  const DanceListBlocProvider({
    super.key,

    /// DanceListWidgetParams
    this.ofSearch,
    this.danceListBloc,
    this.ofArtistId,
    this.ofVideoId,

    /// Selection
    this.preselectedDances,

    /// Widget params
    required this.child,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtistId == null && ofVideoId == null));

  @override
  Widget build(BuildContext context) {
    if ((danceListBloc != null)) {
      return BlocProvider<DanceListBloc>.value(
        value: danceListBloc!,
        child: child,
      );
    } else {
      return BlocProvider(
        create: (context) {
          final danceListBloc = DanceListBloc(
            danceRepository:
                Provider.of<DanceRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (preselectedDances?.isNotEmpty ?? false) {
            danceListBloc.add(DanceListSelect(dances: preselectedDances!));
          }

          danceListBloc.add(DanceListLoad(
            ofSearch: ofSearch,
            ofArtistId: ofArtistId,
            ofVideoId: ofVideoId,
          ));
          return danceListBloc;
        },
        child: child,
      );
    }
  }
}

class DanceListView extends StatefulWidget
    implements DanceListWidgetParams, EntityListViewParams {
  /// DanceListWidgetParams
  @override
  final DanceListBloc? danceListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtistId;
  @override
  final String? ofVideoId;

  /// EntityListViewParams
  @override
  final Axis scrollDirection;
  @override
  final ScrollPhysics? physics;
  @override
  final EdgeInsetsGeometry? padding;

  const DanceListView({
    super.key,

    /// DanceListWidgetParams
    this.danceListBloc,
    this.ofSearch,
    this.ofArtistId,
    this.ofVideoId,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtistId == null && ofVideoId == null));

  @override
  State<DanceListView> createState() => _DanceListViewState();
}

class _DanceListViewState extends State<DanceListView> {
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  Widget build(BuildContext context) {
    return DanceListBlocProvider(
      danceListBloc: widget.danceListBloc,
      ofSearch: widget.ofSearch,
      ofArtistId: widget.ofArtistId,
      ofVideoId: widget.ofVideoId,
      child: BlocListener<DanceListBloc, DanceListState>(
        listener: (context, DanceListState state) {
          switch (state.status) {
            case DanceListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.finishLoad();
              } else {
                _refreshController.finishLoad(IndicatorResult.noMore);
              }
              break;
            case DanceListStatus.loadingFailure:
              _refreshController.finishLoad(IndicatorResult.fail);
              break;
            case DanceListStatus.refreshingSuccess:
              _refreshController.finishRefresh(IndicatorResult.success);
              break;
            case DanceListStatus.refreshingFailure:
              _refreshController.finishRefresh(IndicatorResult.fail);
              break;
            default:
          }
        },
        child: BlocBuilder<DanceListBloc, DanceListState>(
          builder: (context, state) {
            final danceListBloc = BlocProvider.of<DanceListBloc>(context);

            return EasyRefresh(
              controller: _refreshController,
              header: (widget.scrollDirection == Axis.horizontal)
                  ? const MaterialHeader()
                  : null,
              footer: (widget.scrollDirection == Axis.horizontal)
                  ? const MaterialFooter()
                  : null,
              onRefresh: () {
                danceListBloc.add(const DanceListRefresh());
              },
              onLoad: () {
                danceListBloc.add(const DanceListLoadMore());
              },
              child: ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                itemCount: state.dances.length,
                itemBuilder: (context, index) {
                  final DanceViewModel dance = state.dances[index];
                  final DanceListBloc danceListBloc =
                      BlocProvider.of<DanceListBloc>(context);
                  switch (widget.scrollDirection) {
                    case Axis.vertical:
                      if (state.selectedDances.isEmpty) {
                        return DanceListTile(
                          dance: dance,
                          onLongPress: (item) {
                            danceListBloc.add(
                              DanceListSelect(dances: [item]),
                            );
                          },
                        );
                      } else {
                        return CheckboxDanceListTile(
                          dance: dance,
                          value: state.selectedDances
                              .any((element) => element.id == dance.id),
                          onChanged: (bool? value) {
                            danceListBloc.add(
                              (value == true)
                                  ? DanceListSelect(dances: [dance])
                                  : DanceListUnselect(dances: [dance]),
                            );
                          },
                        );
                      }
                    case Axis.horizontal:
                      return DanceCard(dance: dance);
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

class DancesSection extends StatelessWidget
    implements DanceListWidgetParams, EntitiesSectionWidgetParams {
  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onSectionTap;

  /// DanceListWidgetParams
  @override
  final DanceListBloc? danceListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtistId;
  @override
  final String? ofVideoId;

  const DancesSection({
    super.key,

    /// DanceListWidgetParams
    this.danceListBloc,
    this.ofSearch,
    this.ofArtistId,
    this.ofVideoId,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtistId == null && ofVideoId == null));

  @override
  Widget build(BuildContext context) {
    return DanceListBlocProvider(
      danceListBloc: danceListBloc,
      ofSearch: ofSearch,
      ofArtistId: ofArtistId,
      ofVideoId: ofVideoId,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SectionTile(
                leading: Icon(MdiIcons.shoeBallet),
                title: Text(label ?? 'Dances'),
                onTap: onSectionTap ??
                    () {
                      AutoRouter.of(context).push(
                        DanceListRoute(
                          danceListBloc:
                              BlocProvider.of<DanceListBloc>(context),
                        ),
                      );
                    },
              ),
              SizedBox(
                height: AppStyles.cardHeight,
                child: DanceListView(
                  danceListBloc: BlocProvider.of<DanceListBloc>(context),
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
