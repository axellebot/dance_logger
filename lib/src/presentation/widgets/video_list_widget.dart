import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoListView extends StatefulWidget {
  final Axis scrollDirection;

  const VideoListView({
    super.key,
    this.scrollDirection = Axis.vertical,
  });

  @override
  State<StatefulWidget> createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  final _scrollController = ScrollController();

  _VideoListViewState();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoListBloc, VideoListState>(
      builder: (context, state) {
        switch (state.status) {
          case VideoListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
            );
          case VideoListStatus.failure:
          case VideoListStatus.success:
            if (state.videos.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                label: 'No Videos',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.videos.length
                    : state.videos.length + 1,
                itemBuilder: (context, index) {
                  return (index < state.videos.length)
                      ? (widget.scrollDirection == Axis.vertical)
                          ? VideoItemTile(video: state.videos[index])
                          : VideoItemCard(video: state.videos[index])
                      : const RightListLoadingIndicator();
                },
              );
            }
          default:
            return ErrorListView(
              scrollDirection: widget.scrollDirection,
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }

  void _onScroll() {
    if (_shouldLoadMore) {
      context.read<VideoListBloc>().add(const VideoListLoadMore());
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
