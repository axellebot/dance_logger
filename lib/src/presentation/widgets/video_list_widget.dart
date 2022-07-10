import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoListView extends StatelessWidget {
  final Axis scrollDirection;

  const VideoListView({
    super.key,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: Add pull down to refresh
    return BlocBuilder<VideoListBloc, VideoListState>(
      builder: (BuildContext context, VideoListState state) {
        if (state is VideoListUninitialized) {
          return ListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is VideoListRefreshing) {
          return LoadingListView(
            scrollDirection: scrollDirection,
          );
        } else if (state is VideoListLoaded) {
          if (state.videos.isNotEmpty) {
            return _VideoListViewLoaded(
              scrollDirection: scrollDirection,
            );
          } else {
            return ListView(
              scrollDirection: scrollDirection,
              children: [
                (scrollDirection == Axis.vertical)
                    ? const ListTile(title: Text('No Videos'))
                    : const Card(child: Text('No Videos'))
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

class _VideoListViewLoaded extends StatefulWidget {
  final Axis scrollDirection;

  const _VideoListViewLoaded({
    super.key,
    required this.scrollDirection,
  });

  @override
  State<StatefulWidget> createState() => _VideoListViewLoadedState();
}

class _VideoListViewLoadedState extends State<_VideoListViewLoaded> {
  final _scrollController = ScrollController();

  _VideoListViewLoadedState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoListBloc, VideoListState>(
      builder: (context, state) {
        if (state is VideoListLoaded) {
          return ListView.builder(
            scrollDirection: widget.scrollDirection,
            controller: _scrollController,
            itemCount: state.hasReachedMax
                ? state.videos.length
                : state.videos.length + 1,
            itemBuilder: (context, index) {
              if (widget.scrollDirection == Axis.vertical) {
                return (index < state.videos.length)
                    ? (widget.scrollDirection == Axis.vertical)
                        ? VideoItemTile(video: state.videos[index])
                        : VideoItemCard(video: state.videos[index])
                    : const BottomListLoadingIndicator();
              }
              return ErrorListView(
                error: NotSupportedError(message: '${widget.scrollDirection}'),
              );
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
      context.read<VideoListBloc>().add(const VideoListLoadMore());
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
