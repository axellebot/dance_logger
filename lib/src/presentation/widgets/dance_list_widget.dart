import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DanceListView extends StatefulWidget implements DanceListParams {
  /// ListBloc params
  final DanceListBloc? danceListBloc;

  /// DanceListParams
  @override
  final String? ofArtist;
  @override
  final String? ofVideo;

  /// ListView params
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const DanceListView({
    super.key,

    /// ListBloc params
    this.danceListBloc,

    /// ArtistListParams
    this.ofArtist,
    this.ofVideo,

    /// ListView params
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _DanceListViewState();
}

class _DanceListViewState extends State<DanceListView> {
  final _scrollController = ScrollController();

  _DanceListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    final Widget mainContent = BlocBuilder<DanceListBloc, DanceListState>(
      builder: (context, state) {
        switch (state.status) {
          case DanceListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
              physics: widget.physics,
              padding: widget.padding,
            );
          case DanceListStatus.failure:
          case DanceListStatus.success:
          case DanceListStatus.refreshing:
            if (state.dances.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                label: 'No Dances',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                controller: _scrollController,
                physics: widget.physics,
                padding: widget.padding,
                itemCount: state.hasReachedMax
                    ? state.dances.length
                    : state.dances.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.dances.length) {
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
                                DanceListSelect(danceId: dance.id),
                              );
                            },
                          );
                        } else {
                          return CheckboxDanceListTile(
                            dance: dance,
                            value: state.selectedDances.contains(dance.id),
                            onChanged: (bool? value) {
                              danceListBloc.add(
                                (value == true)
                                    ? DanceListSelect(danceId: dance.id)
                                    : DanceListUnselect(danceId: dance.id),
                              );
                            },
                          );
                        }
                      case Axis.horizontal:
                        return DanceCard(dance: dance);
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

    return (widget.danceListBloc != null)
        ? BlocProvider<DanceListBloc>.value(
            value: widget.danceListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => DanceListBloc(
              danceRepository:
                  Provider.of<DanceRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(DanceListLoad(
                ofArtist: widget.ofArtist,
                ofVideo: widget.ofVideo,
              )),
            child: mainContent,
          );
  }

  void _onScroll() {
    if (_shouldLoadMore) {
      context.read<DanceListBloc>().add(const DanceListLoadMore());
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

class DancesSection extends StatelessWidget implements DanceListParams {
  /// ListBloc params
  final DanceListBloc? danceListBloc;

  /// DanceListParams
  @override
  final String? ofArtist;
  @override
  final String? ofVideo;

  const DancesSection({
    super.key,

    /// ListBloc params
    this.danceListBloc,

    /// DanceListParams
    this.ofArtist,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    final Widget mainContent = Builder(
      builder: (context) {
        return Column(
          children: [
            SectionTile(
              title: const Text('Dances'),
              onTap: () {
                AutoRouter.of(context).push(
                  DanceListRoute(
                    danceListBloc: BlocProvider.of<DanceListBloc>(context),
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
    );

    return (danceListBloc != null)
        ? BlocProvider<DanceListBloc>.value(
            value: danceListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => DanceListBloc(
              danceRepository:
                  Provider.of<DanceRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(DanceListLoad(
                ofArtist: ofArtist,
                ofVideo: ofVideo,
              )),
            child: mainContent,
          );
  }
}
