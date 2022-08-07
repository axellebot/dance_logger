import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureListView extends StatefulWidget {
  final Axis scrollDirection;
  final EdgeInsets? padding;

  const FigureListView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.padding,
  });

  @override
  State<StatefulWidget> createState() => _FigureListViewState();
}

class _FigureListViewState extends State<FigureListView> {
  final _scrollController = ScrollController();

  _FigureListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FigureListBloc, FigureListState>(
      builder: (context, state) {
        switch (state.status) {
          case FigureListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
              padding: widget.padding,
            );

          case FigureListStatus.failure:
          case FigureListStatus.success:
            if (state.figures.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                padding: widget.padding,
                label: 'No Figures',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                padding: widget.padding,
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.figures.length
                    : state.figures.length + 1,
                itemBuilder: (context, index) {
                  return (index < state.figures.length)
                      ? (widget.scrollDirection == Axis.vertical)
                          ? FigureItemTile(figure: state.figures[index])
                          : FigureItemCard(figure: state.figures[index])
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
      context.read<FigureListBloc>().add(const FigureListLoadMore());
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
