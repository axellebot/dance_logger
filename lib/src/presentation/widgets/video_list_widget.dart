import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class VideoListView extends StatefulWidget implements VideoListParams {
  /// ListBloc params
  final VideoListBloc? videoListBloc;

  /// VideoListParams
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  /// ListView params
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsets? padding;

  const VideoListView({
    super.key,

    /// ListBloc params
    this.videoListBloc,

    /// VideoListParams
    this.ofArtist,
    this.ofDance,
    this.ofFigure,

    /// ListView params
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
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
    final Widget mainContent = BlocBuilder<VideoListBloc, VideoListState>(
      builder: (BuildContext context, VideoListState state) {
        switch (state.status) {
          case VideoListStatus.loading:
            return LoadingListView(
              scrollDirection: widget.scrollDirection,
              physics: widget.physics,
              padding: widget.padding,
            );
          case VideoListStatus.failure:
          case VideoListStatus.success:
            if (state.videos.isEmpty) {
              return EmptyListView(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                label: 'No Videos',
              );
            } else {
              return ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.videos.length
                    : state.videos.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.videos.length) {
                    final VideoViewModel video = state.videos[index];
                    final VideoListBloc videoListBloc =
                        BlocProvider.of<VideoListBloc>(context);
                    switch (widget.scrollDirection) {
                      case Axis.vertical:
                        if (state.selectedVideos.isEmpty) {
                          return VideoListTile(
                            video: video,
                            onLongPress: () {
                              videoListBloc.add(
                                VideoListSelect(videoId: video.id),
                              );
                            },
                          );
                        } else {
                          return CheckboxVideoListTile(
                            video: video,
                            value: state.selectedVideos.contains(video.id),
                            onChanged: (bool? value) {
                              videoListBloc.add(
                                (value == true)
                                    ? VideoListSelect(videoId: video.id)
                                    : VideoListUnselect(videoId: video.id),
                              );
                            },
                          );
                        }
                      case Axis.horizontal:
                        return VideoCard(video: video);
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
              padding: widget.padding,
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );

    return (widget.videoListBloc != null)
        ? BlocProvider<VideoListBloc>.value(
            value: widget.videoListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => VideoListBloc(
              videoRepository:
                  Provider.of<VideoRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(VideoListLoad(
                ofArtist: widget.ofArtist,
                ofDance: widget.ofDance,
                ofFigure: widget.ofFigure,
              )),
            child: mainContent,
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

class VideosSection extends StatelessWidget implements VideoListParams {
  /// ListBloc params
  final VideoListBloc? videoListBloc;

  /// VideoListParams
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  const VideosSection({
    super.key,

    /// ListBloc params
    this.videoListBloc,

    /// VideoListParams
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
  });

  @override
  Widget build(BuildContext context) {
    final Widget mainContent = Builder(
      builder: (context) {
        return Column(
          children: [
            SectionTile(
              title: const Text('Videos'),
              onTap: () {
                AutoRouter.of(context).push(
                  VideoListRoute(
                    videoListBloc: BlocProvider.of<VideoListBloc>(context),
                  ),
                );
              },
            ),
            SizedBox(
              height: AppStyles.cardHeight,
              child: VideoListView(
                videoListBloc: BlocProvider.of<VideoListBloc>(context),
                scrollDirection: Axis.horizontal,
              ),
            ),
          ],
        );
      },
    );

    return (videoListBloc != null)
        ? BlocProvider<VideoListBloc>.value(
            value: videoListBloc!,
            child: mainContent,
          )
        : BlocProvider(
            create: (context) => VideoListBloc(
              videoRepository:
                  Provider.of<VideoRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(VideoListLoad(
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofFigure: ofFigure,
              )),
            child: mainContent,
          );
  }
}
