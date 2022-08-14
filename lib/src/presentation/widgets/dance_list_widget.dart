import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanceListView extends StatefulWidget {
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const DanceListView({
    super.key,
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
    return BlocBuilder<DanceListBloc, DanceListState>(
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
                        return DanceChip(dance: state.dances[index]);
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
