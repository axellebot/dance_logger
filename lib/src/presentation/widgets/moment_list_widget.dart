import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class MomentListWidgetParams implements MomentListParams {
  /// ListBloc params
  final MomentListBloc? momentListBloc;

  MomentListWidgetParams(this.momentListBloc);
}

class MomentListBlocProvider extends StatelessWidget
    implements MomentListWidgetParams {
  /// MomentListWidgetParams
  @override
  final MomentListBloc? momentListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// Selection
  final List<MomentViewModel>? preselectedMoments;

  /// Widget params
  final Widget child;

  const MomentListBlocProvider({
    super.key,

    /// MomentListWidgetParams
    this.momentListBloc,
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,

    /// Selection
    this.preselectedMoments,

    /// Widget params
    required this.child,
  }) : assert(momentListBloc == null ||
            (ofArtist == null && ofFigure == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    if ((momentListBloc != null)) {
      return BlocProvider<MomentListBloc>.value(
        value: momentListBloc!,
        child: child,
      );
    } else {
      return BlocProvider(
        create: (context) {
          final momentListBloc = MomentListBloc(
            momentRepository:
                Provider.of<MomentRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (preselectedMoments?.isNotEmpty ?? false) {
            momentListBloc.add(MomentListSelect(moments: preselectedMoments!));
          }

          momentListBloc.add(MomentListLoad(
            ofArtist: ofArtist,
            ofFigure: ofFigure,
            ofVideo: ofVideo,
          ));

          return momentListBloc;
        },
        child: child,
      );
    }
  }
}

class MomentListView extends StatefulWidget
    implements MomentListWidgetParams, EntityListViewParams {
  /// MomentListWidgetParams
  @override
  final MomentListBloc? momentListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// Custom
  final ItemCallback<MomentViewModel>? onItemTap;

  /// EntityListViewParams
  @override
  final Axis scrollDirection;
  @override
  final ScrollPhysics? physics;
  @override
  final EdgeInsets? padding;

  const MomentListView({
    super.key,

    /// MomentListWidgetParams
    this.momentListBloc,
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,

    /// Custom
    this.onItemTap,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(momentListBloc == null ||
            (ofArtist == null && ofFigure == null && ofVideo == null));

  @override
  State<MomentListView> createState() => _MomentListViewState();
}

class _MomentListViewState extends State<MomentListView> {
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
    controlFinishLoad: true,
  );

  @override
  Widget build(BuildContext context) {
    return MomentListBlocProvider(
      momentListBloc: widget.momentListBloc,
      ofArtist: widget.ofArtist,
      ofFigure: widget.ofFigure,
      ofVideo: widget.ofVideo,
      child: BlocListener<MomentListBloc, MomentListState>(
        listener: (context, MomentListState state) {
          switch (state.status) {
            case MomentListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.finishLoad();
              } else {
                _refreshController.finishLoad(IndicatorResult.noMore);
              }
              break;
            case MomentListStatus.loadingFailure:
              _refreshController.finishLoad(IndicatorResult.fail);
              break;
            case MomentListStatus.refreshingSuccess:
              _refreshController.finishRefresh(IndicatorResult.success);
              break;
            case MomentListStatus.refreshingFailure:
              _refreshController.finishRefresh(IndicatorResult.fail);
              break;
            default:
          }
        },
        child: BlocBuilder<MomentListBloc, MomentListState>(
          builder: (BuildContext context, MomentListState state) {
            final momentListBloc = BlocProvider.of<MomentListBloc>(context);

            return EasyRefresh(
              controller: _refreshController,
              header: (widget.scrollDirection == Axis.horizontal)
                  ? const MaterialHeader()
                  : null,
              footer: (widget.scrollDirection == Axis.horizontal)
                  ? const MaterialFooter()
                  : null,
              onRefresh: () {
                momentListBloc.add(const MomentListRefresh());
              },
              onLoad: () {
                momentListBloc.add(const MomentListLoadMore());
              },
              child: ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                itemCount: state.moments.length,
                itemBuilder: (context, index) {
                  final MomentViewModel moment = state.moments[index];
                  final MomentListBloc momentListBloc =
                      BlocProvider.of<MomentListBloc>(context);
                  switch (widget.scrollDirection) {
                    case Axis.vertical:
                      if (state.selectedMoments.isEmpty) {
                        return MomentListTile(
                          moment: moment,
                          onTap: widget.onItemTap,
                          onLongPress: (item) {
                            momentListBloc.add(
                              MomentListSelect(moments: [item]),
                            );
                          },
                        );
                      } else {
                        return CheckboxMomentListTile(
                          moment: moment,
                          value: state.selectedMoments
                              .any((element) => element.id == moment.id),
                          onChanged: (bool? value) {
                            momentListBloc.add(
                              (value == true)
                                  ? MomentListSelect(moments: [moment])
                                  : MomentListUnselect(moments: [moment]),
                            );
                          },
                        );
                      }
                    case Axis.horizontal:
                      return MomentChip(
                        moment: moment,
                        onTap: widget.onItemTap,
                      );
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

class MomentsSection extends StatelessWidget
    implements MomentListWidgetParams, EntitiesSectionWidgetParams {
  /// MomentListWidgetParams
  @override
  final MomentListBloc? momentListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onSectionTap;

  /// Custom
  final ItemCallback<MomentViewModel>? onItemTap;

  const MomentsSection({
    super.key,

    /// MomentListWidgetParams
    this.momentListBloc,
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,

    /// Custom
    this.onItemTap,
  }) : assert(momentListBloc == null ||
            (ofArtist == null && ofFigure == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return MomentListBlocProvider(
      momentListBloc: momentListBloc,
      ofArtist: ofArtist,
      ofFigure: ofFigure,
      ofVideo: ofVideo,
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionTile(
                leading: const Icon(Icons.timer),
                title: Text(label ?? 'Moments'),
                onTap: onSectionTap,
              ),
              SizedBox(
                height: AppStyles.chipHeight,
                child: MomentListView(
                  momentListBloc: BlocProvider.of<MomentListBloc>(context),
                  scrollDirection: Axis.horizontal,
                  onItemTap: onItemTap,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
