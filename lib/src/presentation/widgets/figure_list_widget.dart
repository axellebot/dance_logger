import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureListView extends StatelessWidget {
  final Axis scrollDirection;

  const FigureListView({
    super.key,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Add pull down to refresh
    return BlocBuilder<FigureListBloc, FigureListState>(
      builder: (BuildContext context, FigureListState state) {
        if (state is FigureListUninitialized) {
          return ListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is FigureListRefreshing) {
          return LoadingListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is FigureListLoaded) {
          if (state.figures.isNotEmpty) {
            return _FigureListViewLoaded(
              scrollDirection: scrollDirection,
            );
          } else {
            return ListView(
              scrollDirection: scrollDirection,
              children: [
                (scrollDirection == Axis.vertical)
                    ? const ListTile(title: Text('No Figures'))
                    : const Card(child: Text('No Figures'))
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

class _FigureListViewLoaded extends StatefulWidget {
  final Axis scrollDirection;

  const _FigureListViewLoaded({
    super.key,
    required this.scrollDirection,
  });

  @override
  State<StatefulWidget> createState() => _FigureListViewLoadedState();
}

class _FigureListViewLoadedState extends State<_FigureListViewLoaded> {
  final _scrollController = ScrollController();

  _FigureListViewLoadedState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FigureListBloc, FigureListState>(
      builder: (context, state) {
        if (state is FigureListLoaded) {
          return ListView.builder(
            scrollDirection: widget.scrollDirection,
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
        return ErrorListView(
          scrollDirection: widget.scrollDirection,
          error: NotSupportedError(message: '${state.runtimeType}'),
        );
      },
    );
  }

  void _onScroll() {
    if (_isAtEnd) {
      context.read<FigureListBloc>().add(const FigureListLoadMore());
    }
  }

  bool get _isAtEnd {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }
}
