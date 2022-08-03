import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeListView extends StatelessWidget {
  final Axis scrollDirection;

  const PracticeListView({
    super.key,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Add pull down to refresh
    return BlocBuilder<PracticeListBloc, PracticeListState>(
      builder: (BuildContext context, PracticeListState state) {
        if (state is PracticeListUninitialized) {
          return ListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is PracticeListRefreshing) {
          return LoadingListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is PracticeListLoaded) {
          if (state.practices.isNotEmpty) {
            return _PracticeListViewLoaded(
              scrollDirection: scrollDirection,
            );
          } else {
            return ListView(
              scrollDirection: scrollDirection,
              children: [
                (scrollDirection == Axis.vertical)
                    ? const ListTile(title: Text('No Practices'))
                    : const Card(child: Text('No Practices'))
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

class _PracticeListViewLoaded extends StatefulWidget {
  final Axis scrollDirection;

  const _PracticeListViewLoaded({
    super.key,
    required this.scrollDirection,
  });

  @override
  State<StatefulWidget> createState() => _PracticeListViewLoadedState();
}

class _PracticeListViewLoadedState extends State<_PracticeListViewLoaded> {
  final _scrollController = ScrollController();

  _PracticeListViewLoadedState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticeListBloc, PracticeListState>(
      builder: (context, state) {
        if (state is PracticeListLoaded) {
          return ListView.builder(
            scrollDirection: widget.scrollDirection,
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.practices.length
                : state.practices.length + 1,
            itemBuilder: (context, index) {
              return (index < state.practices.length)
                  ? (widget.scrollDirection == Axis.vertical)
                      ? PracticeItemTile(practice: state.practices[index])
                      : PracticeItemCard(practice: state.practices[index])
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
      context.read<PracticeListBloc>().add(const PracticeListLoadMore());
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
