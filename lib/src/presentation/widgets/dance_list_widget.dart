import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanceListView extends StatefulWidget {
  final Axis scrollDirection;
  final EdgeInsets? padding;

  const DanceListView({
    super.key,
    this.scrollDirection = Axis.vertical,
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
    // TODO: Add pull down to refresh
    return BlocBuilder<DanceListBloc, DanceListState>(
      builder: (context, state) {
        switch (state.status) {
          case DanceListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
              padding: widget.padding,
            );
          case DanceListStatus.failure:
          case DanceListStatus.success:
            if (state.dances.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                padding: widget.padding,
                label: 'No Dances',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                padding: widget.padding,
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.dances.length
                    : state.dances.length + 1,
                itemBuilder: (context, index) {
                  return (index < state.dances.length)
                      ? (widget.scrollDirection == Axis.vertical)
                          ? DanceItemTile(dance: state.dances[index])
                          : DanceItemChip(dance: state.dances[index])
                      : (widget.scrollDirection == Axis.vertical)
                          ? const BottomListLoadingIndicator()
                          : const RightListLoadingIndicator();
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
