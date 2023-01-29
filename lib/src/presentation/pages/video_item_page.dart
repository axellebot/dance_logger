import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoDetailsPage extends StatefulWidget implements AutoRouteWrapper {
  final String videoId;

  const VideoDetailsPage({
    super.key,
    required this.videoId,
  });

  @override
  State<StatefulWidget> createState() => _VideoDetailsPage();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<VideoDetailBloc>(
      create: (BuildContext context) {
        return VideoDetailBloc(
          videoRepository: RepositoryProvider.of<VideoRepository>(context),
          mapper: ModelMapper(),
        )..add(VideoDetailLoad(videoId: videoId));
      },
      child: this,
    );
  }
}

class _VideoDetailsPage extends State<VideoDetailsPage> {
  YoutubePlayerController? _videoController;
  final DraggableScrollableController _bottomSheetController =
      DraggableScrollableController();

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  GlobalKey videoPlayerWidgetKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<VideoDetailBloc, VideoDetailState>(
            listenWhen: (VideoDetailState previous, VideoDetailState current) =>
                previous.video?.id != current.video?.id,
            listener: (BuildContext context, VideoDetailState state) {
              if (state.video != null) {
                final String? videoId =
                    YoutubePlayer.convertUrlToId(state.video!.url);
                if (videoId != null) {
                  _videoController?.dispose();
                  _videoController = YoutubePlayerController(
                    initialVideoId: videoId,
                    flags: const YoutubePlayerFlags(
                      showLiveFullscreenButton: false,
                    ),
                  );
                } else {
                  _videoController?.dispose();
                  _videoController = null;
                }
              } else {
                _videoController?.dispose();
                _videoController = null;
              }
            }),
        BlocListener<VideoDetailBloc, VideoDetailState>(
          listener: (context, state) {
            switch (state.status) {
              case VideoDetailStatus.refreshingSuccess:
                _refreshController.refreshCompleted();
                break;
              case VideoDetailStatus.refreshingFailure:
                _refreshController.refreshFailed();
                break;
              default:
            }
          },
        ),
      ],
      child: BlocBuilder<VideoDetailBloc, VideoDetailState>(
        builder: (BuildContext context, VideoDetailState state) {
          final VideoDetailBloc videoDetailBloc =
              BlocProvider.of<VideoDetailBloc>(context);

          return Scaffold(
            body: SafeArea(
              child: Builder(
                builder: (context) {
                  double videoPlayerFactor =
                      ((9 / 16) * MediaQuery.of(context).size.width) /
                          MediaQuery.of(context).size.height;
                  double remoteFactor = 1 - videoPlayerFactor;
                  return BlocListener<VideoDetailBloc, VideoDetailState>(
                    listenWhen:
                        (VideoDetailState previous, VideoDetailState current) =>
                            previous.remoteOpened != current.remoteOpened,
                    listener: (BuildContext context, VideoDetailState state) {
                      if (state.remoteOpened != null) {
                        if (state.remoteOpened!) {
                          _bottomSheetController.animateTo(
                            remoteFactor,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOutCubic,
                          );
                        } else {
                          _bottomSheetController.animateTo(
                            0.0,
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOutCubic,
                          );
                        }
                      }
                    },
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Hero(
                              tag:
                                  'img-${state.video?.id ?? state.ofId ?? "not_loaded"}',
                              child: AspectRatio(
                                key: videoPlayerWidgetKey,
                                aspectRatio: 16 / 9,
                                child: (_videoController != null)
                                    ? YoutubePlayer(
                                        thumbnail: VideoThumbnail(
                                            url: state.video?.url),
                                        controller: _videoController!,
                                        bottomActions: [
                                          TextButton(
                                            onPressed: () {
                                              videoDetailBloc
                                                  .add(VideoDetailToggleRemote(
                                                opened: !(state.remoteOpened ??
                                                        false) ??
                                                    false,
                                              ));
                                            },
                                            child: const Text('Moments >'),
                                          ),
                                          const SizedBox(width: 14.0),
                                          CurrentPosition(),
                                          const SizedBox(width: 8.0),
                                          ProgressBar(
                                            isExpanded: true,
                                          ),
                                          RemainingDuration(),
                                          const PlaybackSpeedButton(),
                                          // FullScreenButton(),
                                        ],
                                      )
                                    : VideoThumbnail(url: state.video?.url),
                              ),
                            ),
                            // CustomScrollView(
                            //   slivers: [
                            //     SliverToBoxAdapter(
                            //       child: Column(
                            //         mainAxisSize: MainAxisSize.min,
                            //         children: [
                            //           ListTile(
                            //             title: Text(
                            //                 state.video?.name ?? 'Video Title'),
                            //             subtitle: Text(
                            //                 state.video?.url ?? 'Video url'),
                            //           ),
                            //           SizedBox(
                            //             height: 40,
                            //             child: ListView(
                            //               scrollDirection: Axis.horizontal,
                            //               children: [
                            //                 const SizedBox(width: 10),
                            //                 ActionChip(
                            //                   label: const Text("Copy URL"),
                            //                   avatar: const Icon(Icons.copy),
                            //                   onPressed: () {
                            //                     Clipboard.setData(ClipboardData(
                            //                         text: state.video!.url));
                            //                   },
                            //                 ),
                            //                 const SizedBox(width: 10),
                            //                 ActionChip(
                            //                   label: const Text("Edit"),
                            //                   avatar: const Icon(Icons.edit),
                            //                   onPressed: () {
                            //                     AutoRouter.of(context).push(
                            //                       VideoEditRoute(
                            //                         videoId: state.video!.id,
                            //                       ),
                            //                     );
                            //                   },
                            //                 ),
                            //                 const SizedBox(width: 10),
                            //                 DeleteActionChip(
                            //                   onDeleted: () {
                            //                     videoDetailBloc.add(
                            //                         const VideoDetailDelete());
                            //                   },
                            //                 )
                            //               ],
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ),
                            //     SliverFillRemaining(
                            //       child: SmartRefresher(
                            //         controller: _refreshController,
                            //         enablePullDown: true,
                            //         onRefresh: () {
                            //           videoDetailBloc
                            //               .add(const VideoDetailRefresh());
                            //         },
                            //         child: ListView(
                            //           children: <Widget>[
                            //             if (state.video != null)
                            //               FiguresSection(
                            //                 // label: 'Figures of ${state.video!.name}',
                            //                 ofVideo: state.video!.id,
                            //               ),
                            //             if (state.video != null)
                            //               ArtistsSection(
                            //                 label: 'Cast',
                            //                 // label: 'Artists of ${state.video!.name}',
                            //                 ofVideo: state.video!.id,
                            //               ),
                            //             if (state.video != null)
                            //               DancesSection(
                            //                 // label: 'Dances of ${state.video!.name}',
                            //                 ofVideo: state.video!.id,
                            //               ),
                            //             if (state.video != null)
                            //               EntityInfoListTile(
                            //                 createdAt: state.video!.createdAt,
                            //                 updateAt: state.video!.updatedAt,
                            //                 version: state.video!.version,
                            //               ),
                            //           ],
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                        DraggableScrollableSheet(
                          expand: true,
                          snap: true,
                          minChildSize: 0.0,
                          maxChildSize: 1.0,
                          initialChildSize: 0.0,
                          snapSizes: [
                            remoteFactor,
                          ],
                          controller: _bottomSheetController,
                          builder: (BuildContext context,
                              ScrollController scrollController) {
                            return Container(
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    topRight: Radius.circular(10.0)),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: CustomScrollView(
                                controller: scrollController,
                                slivers: [
                                  SliverPersistentHeader(
                                    pinned: true,
                                    delegate: MomentHeaderDelegate(
                                      onExit: () {
                                        videoDetailBloc
                                            .add(const VideoDetailToggleRemote(
                                          opened: false,
                                        ));
                                      },
                                    ),
                                  ),
                                  SliverFillRemaining(
                                    child: MomentListView(
                                      ofVideo: state.video!.id,
                                      onItemTap:
                                          (MomentViewModel momentViewModel) {
                                        _videoController
                                            ?.seekTo(momentViewModel.startTime);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _videoController?.pause();
    super.deactivate();
  }

  @override
  void activate() {
    super.activate();
    // Play video while navigating back here.
    _videoController?.play();
  }

  @override
  void dispose() {
    _videoController?.dispose();
    _bottomSheetController?.dispose();
    _refreshController?.dispose();
    super.dispose();
  }
}

class VideoCreatePage extends VideoEditPage {
  const VideoCreatePage({super.key});
}

class VideoEditPage extends StatelessWidget implements AutoRouteWrapper {
  final String? videoId;

  const VideoEditPage({
    super.key,
    this.videoId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoEditBloc, VideoEditState>(
      builder: (context, VideoEditState state) {
        switch (state.status) {
          case VideoEditStatus.initial:
          case VideoEditStatus.loading:
            return const LoadingPage();
          case VideoEditStatus.failure:
            return ErrorPage(error: state.error!);
          case VideoEditStatus.ready:
          case VideoEditStatus.editSuccess:
            final VideoEditBloc videoEditBloc =
                BlocProvider.of<VideoEditBloc>(context);
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
                title: Text(
                  state.initialVideo != null ? "Edit video" : "Create video",
                ),
                actions: <Widget>[
                  SaveButton(
                    onSaved: () {
                      videoEditBloc.add(const VideoEditSubmit());
                    },
                  ),
                  if (state.initialVideo != null)
                    DeleteIconButton(
                      onDeleted: () {
                        videoEditBloc.add(const VideoEditDelete());
                      },
                    ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: AppStyles.formPadding,
                  child: const VideoForm(),
                ),
              ),
            );
          default:
            return ErrorPage(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => VideoEditBloc(
        videoRepository: RepositoryProvider.of<VideoRepository>(context),
        mapper: ModelMapper(),
      )..add(VideoEditStart(videoId: videoId)),
      child: this,
    );
  }
}

class MomentHeaderDelegate extends SliverPersistentHeaderDelegate {
  final VoidCallback? onExit;

  MomentHeaderDelegate({this.onExit});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 8),
        Center(
          child: Container(
            width: 40,
            height: 6,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        const SizedBox(height: 4),
        ListTile(
          trailing: IconButton(
            onPressed: onExit,
            icon: const Icon(Icons.close),
          ),
          title: const Text(
            'Moments',
            textAlign: TextAlign.left,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const Divider(thickness: 1.0),
      ],
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
