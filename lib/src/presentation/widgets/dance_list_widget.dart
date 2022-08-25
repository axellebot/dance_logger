import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  final String? ofArtist;
  @override
  final String? ofVideo;

  /// Widget params
  final Widget child;

  const DanceListBlocProvider({
    super.key,

    /// DanceListWidgetParams
    this.ofSearch,
    this.danceListBloc,
    this.ofArtist,
    this.ofVideo,

    /// Widget params
    required this.child,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return (danceListBloc != null)
        ? BlocProvider<DanceListBloc>.value(
            value: danceListBloc!,
            child: child,
          )
        : BlocProvider(
            create: (context) => DanceListBloc(
              danceRepository:
                  Provider.of<DanceRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(DanceListLoad(
                ofSearch: ofSearch,
                ofArtist: ofArtist,
                ofVideo: ofVideo,
              )),
            child: child,
          );
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
  final String? ofArtist;
  @override
  final String? ofVideo;

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
    this.ofArtist,
    this.ofVideo,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofVideo == null));

  @override
  State<DanceListView> createState() => _DanceListViewState();
}

class _DanceListViewState extends State<DanceListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return DanceListBlocProvider(
      danceListBloc: widget.danceListBloc,
      ofSearch: widget.ofSearch,
      ofArtist: widget.ofArtist,
      ofVideo: widget.ofVideo,
      child: BlocListener<DanceListBloc, DanceListState>(
        listener: (context, DanceListState state) {
          switch (state.status) {
            case DanceListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadNoData();
              }
              break;
            case DanceListStatus.loadingFailure:
              _refreshController.loadFailed();
              break;
            case DanceListStatus.refreshingSuccess:
              _refreshController.refreshCompleted(resetFooterState: true);
              break;
            case DanceListStatus.refreshingFailure:
              _refreshController.refreshFailed();
              break;
            default:
          }
        },
        child: BlocBuilder<DanceListBloc, DanceListState>(
          builder: (context, state) {
            final danceListBloc = BlocProvider.of<DanceListBloc>(context);

            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () {
                danceListBloc.add(const DanceListRefresh());
              },
              onLoading: () {
                danceListBloc.add(const DanceListLoadMore());
              },
              scrollDirection: widget.scrollDirection,
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
                          onLongPress: () {
                            danceListBloc.add(
                              DanceListSelect(dance: dance),
                            );
                          },
                        );
                      } else {
                        return CheckboxDanceListTile(
                          dance: dance,
                          value: state.selectedDances.contains(dance),
                          onChanged: (bool? value) {
                            danceListBloc.add(
                              (value == true)
                                  ? DanceListSelect(dance: dance)
                                  : DanceListUnselect(dance: dance),
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
  final String? ofArtist;
  @override
  final String? ofVideo;

  const DancesSection({
    super.key,

    /// DanceListWidgetParams
    this.danceListBloc,
    this.ofSearch,
    this.ofArtist,
    this.ofVideo,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,
  }) : assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return DanceListBlocProvider(
      danceListBloc: danceListBloc,
      ofSearch: ofSearch,
      ofArtist: ofArtist,
      ofVideo: ofVideo,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SectionTile(
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
