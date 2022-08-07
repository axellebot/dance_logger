import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeListView extends StatefulWidget {
  final Axis scrollDirection;
  final EdgeInsets? padding;

  const PracticeListView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _PracticeListViewState();
}

class _PracticeListViewState extends State<PracticeListView> {
  final _scrollController = ScrollController();

  _PracticeListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticeListBloc, PracticeListState>(
      builder: (context, state) {
        switch (state.status) {
          case PracticeListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
              padding: widget.padding,
            );
          case PracticeListStatus.failure:
          case PracticeListStatus.success:
            if (state.practices.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                padding: widget.padding,
                label: 'No practices',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                padding: widget.padding,
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
