import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class PracticeListWidgetParams implements PracticeListParams {
  /// ListBloc params
  final PracticeListBloc? practiceListBloc;

  PracticeListWidgetParams(this.practiceListBloc);
}

class PracticeListBlocProvider extends StatelessWidget
    implements PracticeListWidgetParams {
  /// PracticeListWidgetParams
  @override
  final PracticeListBloc? practiceListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// Widget params
  final Widget child;

  const PracticeListBlocProvider({
    super.key,

    /// PracticeListWidgetParams
    this.practiceListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// Widget params
    required this.child,
  }) : assert(practiceListBloc == null ||
            (ofArtist == null &&
                ofDance == null &&
                ofFigure == null &&
                ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return (practiceListBloc != null)
        ? BlocProvider<PracticeListBloc>.value(
            value: practiceListBloc!,
            child: child,
          )
        : BlocProvider<PracticeListBloc>(
            create: (context) => PracticeListBloc(
              practiceRepository:
                  Provider.of<PracticeRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(PracticeListLoad(
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofFigure: ofFigure,
                ofVideo: ofVideo,
              )),
            child: child,
          );
  }
}

class PracticeListView extends StatefulWidget
    implements PracticeListWidgetParams, EntityListViewParams {
  /// PracticeListWidgetParams
  @override
  final PracticeListBloc? practiceListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// EntityListViewParams
  @override
  final Axis scrollDirection;
  @override
  final ScrollPhysics? physics;
  @override
  final EdgeInsets? padding;

  const PracticeListView({
    super.key,

    /// PracticeListWidgetParams
    this.practiceListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(practiceListBloc == null ||
            (ofArtist == null &&
                ofDance == null &&
                ofFigure == null &&
                ofVideo == null));

  @override
  State<PracticeListView> createState() => _PracticeListViewState();
}

class _PracticeListViewState extends State<PracticeListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return PracticeListBlocProvider(
      practiceListBloc: widget.practiceListBloc,
      ofArtist: widget.ofArtist,
      ofDance: widget.ofDance,
      ofFigure: widget.ofFigure,
      ofVideo: widget.ofVideo,
      child: BlocListener<PracticeListBloc, PracticeListState>(
        listener: (context, PracticeListState state) {
          switch (state.status) {
            case PracticeListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadNoData();
              }
              break;
            case PracticeListStatus.loadingFailure:
              _refreshController.loadFailed();
              break;
            case PracticeListStatus.refreshingSuccess:
              _refreshController.refreshCompleted(resetFooterState: true);
              break;
            case PracticeListStatus.refreshingFailure:
              _refreshController.refreshFailed();
              break;
            default:
          }
        },
        child: BlocBuilder<PracticeListBloc, PracticeListState>(
          builder: (BuildContext context, PracticeListState state) {
            final practiceListBloc = BlocProvider.of<PracticeListBloc>(context);

            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () {
                practiceListBloc.add(const PracticeListRefresh());
              },
              onLoading: () {
                practiceListBloc.add(const PracticeListLoadMore());
              },
              scrollDirection: widget.scrollDirection,
              child: ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                itemCount: state.practices.length,
                itemBuilder: (context, index) {
                  final PracticeViewModel practice = state.practices[index];
                  final PracticeListBloc practiceListBloc =
                      BlocProvider.of<PracticeListBloc>(context);
                  switch (widget.scrollDirection) {
                    case Axis.vertical:
                      if (state.selectedPractices.isEmpty) {
                        return PracticeListTile(
                          practice: practice,
                          onLongPress: () {
                            practiceListBloc.add(
                              PracticeListSelect(practice: practice),
                            );
                          },
                        );
                      } else {
                        return CheckboxPracticeListTile(
                          practice: practice,
                          value: state.selectedPractices.contains(practice),
                          onChanged: (bool? value) {
                            practiceListBloc.add(
                              (value == true)
                                  ? PracticeListSelect(practice: practice)
                                  : PracticeListUnselect(practice: practice),
                            );
                          },
                        );
                      }
                    case Axis.horizontal:
                      return PracticeCard(practice: practice);
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

class PracticesSection extends StatelessWidget
    implements PracticeListWidgetParams, EntitiesSectionWidgetParams {
  /// PracticeListWidgetParams
  @override
  final PracticeListBloc? practiceListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onSectionTap;

  const PracticesSection({
    super.key,

    /// PracticeListWidgetParams
    this.practiceListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,
  }) : assert(practiceListBloc == null ||
            (ofArtist == null &&
                ofDance == null &&
                ofFigure == null &&
                ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return PracticeListBlocProvider(
      practiceListBloc: practiceListBloc,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofFigure: ofFigure,
      ofVideo: ofVideo,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: Text(label ?? 'Practices'),
                onTap: onSectionTap ??
                    () {
                      AutoRouter.of(context).push(
                        PracticeListRoute(
                          practiceListBloc:
                              BlocProvider.of<PracticeListBloc>(context),
                        ),
                      );
                    },
              ),
              SizedBox(
                height: AppStyles.cardHeight,
                child: PracticeListView(
                  practiceListBloc: BlocProvider.of<PracticeListBloc>(context),
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
