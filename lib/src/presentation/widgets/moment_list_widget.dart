import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class MomentListView extends StatefulWidget implements MomentListParams {
  /// ListBloc params
  final MomentListBloc? momentListBloc;

  /// MomentListParams
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  /// ListView params
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  const MomentListView({
    super.key,

    /// ListBloc params
    this.momentListBloc,

    /// ArtistListParams
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,

    /// ListView params
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _MomentListViewState();
}

class _MomentListViewState extends State<MomentListView> {
  final _scrollController = ScrollController();

  _MomentListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final Widget mainContent = BlocBuilder<MomentListBloc, MomentListState>(
      builder: (BuildContext context, MomentListState state) {
        switch (state.status) {
          case MomentListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
              physics: widget.physics,
              padding: widget.padding,
            );
          case MomentListStatus.failure:
          case MomentListStatus.success:
          case MomentListStatus.refreshing:
            if (state.moments.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                label: 'No Moments',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.moments.length
                    : state.moments.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.moments.length) {
                    final MomentViewModel moment = state.moments[index];
                    final MomentListBloc momentListBloc =
                        BlocProvider.of<MomentListBloc>(context);
                    switch (widget.scrollDirection) {
                      case Axis.vertical:
                        if (state.selectedMoments.isEmpty) {
                          return MomentListTile(
                            moment: moment,
                            onLongPress: () {
                              momentListBloc.add(
                                MomentListSelect(momentId: moment.id),
                              );
                            },
                          );
                        } else {
                          return CheckboxMomentListTile(
                            moment: moment,
                            value: state.selectedMoments.contains(moment.id),
                            onChanged: (bool? value) {
                              momentListBloc.add(
                                (value == true)
                                    ? MomentListSelect(momentId: moment.id)
                                    : MomentListUnselect(momentId: moment.id),
                              );
                            },
                          );
                        }
                      case Axis.horizontal:
                        return MomentChip(moment: moment);
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
              physics: widget.physics,
              padding: widget.padding,
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );

    return (widget.momentListBloc != null)
        ? BlocProvider<MomentListBloc>.value(
            value: widget.momentListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => MomentListBloc(
              momentRepository:
                  Provider.of<MomentRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(MomentListLoad(
                ofArtist: widget.ofArtist,
                ofFigure: widget.ofFigure,
                ofVideo: widget.ofVideo,
              )),
            child: mainContent,
          );
  }

  void _onScroll() {
    if (_shouldLoadMore) {
      context.read<MomentListBloc>().add(const MomentListLoadMore());
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

class MomentsSection extends StatelessWidget implements MomentListParams {
  /// ListBloc params
  final MomentListBloc? momentListBloc;

  /// MomentListParams
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const MomentsSection({
    super.key,

    /// ListBloc params
    this.momentListBloc,

    /// MomentListParams
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    final Widget mainContent = Builder(
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SectionTile(
              title: Text('Moments'),
            ),
            SizedBox(
              height: AppStyles.chipHeight,
              child: MomentListView(
                momentListBloc: BlocProvider.of<MomentListBloc>(context),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        );
      },
    );

    return (momentListBloc != null)
        ? BlocProvider<MomentListBloc>.value(
            value: momentListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => MomentListBloc(
              momentRepository:
                  Provider.of<MomentRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(MomentListLoad(
                ofArtist: ofArtist,
                ofVideo: ofVideo,
              )),
            child: mainContent,
          );
  }
}
