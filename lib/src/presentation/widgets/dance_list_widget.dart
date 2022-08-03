import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanceListView extends StatelessWidget {
  final Axis scrollDirection;

  const DanceListView({
    super.key,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Add pull down to refresh
    return BlocBuilder<DanceListBloc, DanceListState>(
      builder: (BuildContext context, DanceListState state) {
        if (state is DanceListUninitialized) {
          return ListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is DanceListRefreshing) {
          return LoadingListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is DanceListLoaded) {
          if (state.dances.isNotEmpty) {
            return _DanceListViewLoaded(
              scrollDirection: scrollDirection,
            );
          } else {
            return ListView(
              scrollDirection: scrollDirection,
              children: [
                (scrollDirection == Axis.vertical)
                    ? const ListTile(title: Text('No Dances'))
                    : const Card(child: Text('No Dances'))
              ],
            );
          }
        }
        return ErrorListView(
          scrollDirection: scrollDirection,
          error: NotSupportedError(message: '${state.runtimeType}'),
        );
      },
    );
  }
}

class _DanceListViewLoaded extends StatefulWidget {
  final Axis scrollDirection;

  const _DanceListViewLoaded({
    super.key,
    required this.scrollDirection,
  });

  @override
  State<StatefulWidget> createState() => _DanceListViewLoadedState();
}

class _DanceListViewLoadedState extends State<_DanceListViewLoaded> {
  final _scrollController = ScrollController();

  _DanceListViewLoadedState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanceListBloc, DanceListState>(
      builder: (context, state) {
        if (state is DanceListLoaded) {
          return ListView.builder(
            scrollDirection: widget.scrollDirection,
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
        return ErrorListView(
          scrollDirection: widget.scrollDirection,
          error: NotSupportedError(message: '${state.runtimeType}'),
        );
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
