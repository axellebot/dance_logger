import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

abstract class VideoListWidgetParams implements VideoListParams {
  /// ListBloc params
  final VideoListBloc? videoListBloc;

  VideoListWidgetParams(this.videoListBloc);
}

class VideoListBlocProvider extends StatelessWidget
    implements VideoListWidgetParams {
  /// VideoListWidgetParams
  @override
  final VideoListBloc? videoListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  /// Selection
  final List<VideoViewModel>? preselectedVideos;

  /// Widget params
  final Widget child;

  const VideoListBlocProvider({
    super.key,

    /// VideoListWidgetParams
    this.videoListBloc,
    this.ofSearch,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,

    /// Selection
    this.preselectedVideos,

    /// Widget params
    required this.child,
  }) : assert(videoListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofDance == null && ofFigure == null));

  @override
  Widget build(BuildContext context) {
    if ((videoListBloc != null)) {
      return BlocProvider<VideoListBloc>.value(
        value: videoListBloc!,
        child: child,
      );
    } else {
      return BlocProvider<VideoListBloc>(
        create: (context) {
          final videoListBloc = VideoListBloc(
            videoRepository:
                Provider.of<VideoRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (preselectedVideos?.isNotEmpty ?? false) {
            videoListBloc.add(VideoListSelect(videos: preselectedVideos!));
          }

          videoListBloc.add(VideoListLoad(
            ofSearch: ofSearch,
            ofArtist: ofArtist,
            ofDance: ofDance,
            ofFigure: ofFigure,
          ));
          return videoListBloc;
        },
        child: child,
      );
    }
  }
}

class VideoListView extends StatefulWidget
    implements VideoListWidgetParams, EntityListViewParams {
  /// VideoListWidgetParams
  @override
  final VideoListBloc? videoListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  /// EntityListViewParams
  @override
  final Axis scrollDirection;
  @override
  final ScrollPhysics? physics;
  @override
  final EdgeInsets? padding;

  const VideoListView({
    super.key,

    /// VideoListWidgetParams
    this.videoListBloc,
    this.ofSearch,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,

    /// EntityListViewParams
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
  }) : assert(videoListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofDance == null && ofFigure == null));

  @override
  State<VideoListView> createState() => _VideoListViewState();
}

class _VideoListViewState extends State<VideoListView> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return VideoListBlocProvider(
      videoListBloc: widget.videoListBloc,
      ofSearch: widget.ofSearch,
      ofArtist: widget.ofArtist,
      ofDance: widget.ofDance,
      ofFigure: widget.ofFigure,
      child: BlocListener<VideoListBloc, VideoListState>(
        listener: (context, VideoListState state) {
          switch (state.status) {
            case VideoListStatus.loadingSuccess:
              if (!state.hasReachedMax) {
                _refreshController.loadComplete();
              } else {
                _refreshController.loadNoData();
              }
              break;
            case VideoListStatus.loadingFailure:
              _refreshController.loadFailed();
              break;
            case VideoListStatus.refreshingSuccess:
              _refreshController.refreshCompleted(resetFooterState: true);
              break;
            case VideoListStatus.refreshingFailure:
              _refreshController.refreshFailed();
              break;
            default:
          }
        },
        child: BlocBuilder<VideoListBloc, VideoListState>(
          builder: (BuildContext context, VideoListState state) {
            final videoListBloc = BlocProvider.of<VideoListBloc>(context);

            return SmartRefresher(
              controller: _refreshController,
              enablePullDown: true,
              enablePullUp: true,
              onRefresh: () {
                videoListBloc.add(const VideoListRefresh());
              },
              onLoading: () {
                videoListBloc.add(const VideoListLoadMore());
              },
              scrollDirection: widget.scrollDirection,
              child: ListView.builder(
                scrollDirection: widget.scrollDirection,
                physics: widget.physics,
                padding: widget.padding,
                itemCount: state.videos.length,
                itemBuilder: (context, index) {
                  final VideoViewModel video = state.videos[index];
                  final VideoListBloc videoListBloc =
                      BlocProvider.of<VideoListBloc>(context);
                  switch (widget.scrollDirection) {
                    case Axis.vertical:
                      if (state.selectedVideos.isEmpty) {
                        return VideoListTile(
                          video: video,
                          onLongPress: (item) {
                            videoListBloc.add(
                              VideoListSelect(videos: [item]),
                            );
                          },
                        );
                      } else {
                        return CheckboxVideoListTile(
                          video: video,
                          value: state.selectedVideos
                              .any((element) => element.id == video.id),
                          onChanged: (bool? value) {
                            videoListBloc.add(
                              (value == true)
                                  ? VideoListSelect(videos: [video])
                                  : VideoListUnselect(videos: [video]),
                            );
                          },
                        );
                      }
                    case Axis.horizontal:
                      return VideoCard(video: video);
                  }
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class VideosSection extends StatelessWidget
    implements VideoListWidgetParams, EntitiesSectionWidgetParams {
  /// VideoListWidgetParams
  @override
  final VideoListBloc? videoListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  /// EntitiesSectionWidgetParams
  @override
  final String? label;
  @override
  final VoidCallback? onSectionTap;

  const VideosSection({
    super.key,

    /// VideoListWidgetParams
    this.videoListBloc,
    this.ofSearch,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,

    /// EntitiesSectionWidgetParams
    this.label,
    this.onSectionTap,
  }) : assert(videoListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofDance == null && ofFigure == null));

  @override
  Widget build(BuildContext context) {
    return VideoListBlocProvider(
      videoListBloc: videoListBloc,
      ofSearch: ofSearch,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofFigure: ofFigure,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              SectionTile(
                leading: const Icon(Icons.movie),
                title: Text(label ?? 'Videos'),
                onTap: onSectionTap ??
                    () {
                      AutoRouter.of(context).push(
                        VideoListRoute(
                          videoListBloc:
                              BlocProvider.of<VideoListBloc>(context),
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
      ),
    );
  }
}
