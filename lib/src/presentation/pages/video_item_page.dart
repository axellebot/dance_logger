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

  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<VideoDetailBloc, VideoDetailState>(
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
      },
      child: BlocListener<VideoDetailBloc, VideoDetailState>(
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
        child: BlocBuilder<VideoDetailBloc, VideoDetailState>(
          builder: (BuildContext context, VideoDetailState state) {
            final VideoDetailBloc videoDetailBloc =
                BlocProvider.of<VideoDetailBloc>(context);

            Widget? thumbnail = (isYoutube(state.video?.url ?? ""))
                ? Image.network(
                    'https://img.youtube.com/vi/${getYoutubeId(state.video!.url)}/mqdefault.jpg',
                    fit: BoxFit.cover,
                  )
                : Container();

            return Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverFillRemaining(
                    child: SmartRefresher(
                      controller: _refreshController,
                      enablePullDown: true,
                      onRefresh: () {
                        videoDetailBloc.add(const VideoDetailRefresh());
                      },
                      child: ListView(
                        children: <Widget>[
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.3,
                            ),
                            child: Hero(
                              tag:
                                  'img-${state.video?.id ?? state.ofId ?? "not_loaded"}',
                              child: AspectRatio(
                                aspectRatio: 16 / 9,
                                child: (_videoController != null)
                                    ? YoutubePlayer(
                                        thumbnail: thumbnail,
                                        controller: _videoController!,
                                        bottomActions: [
                                          TextButton(
                                            onPressed: () => showBottomSheet(
                                              context: context,
                                              builder: (context) =>
                                                  MomentListView(
                                                ofVideo: state.video!.id,
                                              ),
                                            ),
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
                                    : thumbnail,
                              ),
                            ),
                          ),
                          if (state.video != null)
                            ListTile(
                              title: Text(state.video!.name),
                              subtitle: Text(state.video!.url),
                            ),
                          SizedBox(
                            height: 40,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                const SizedBox(width: 10),
                                ActionChip(
                                  label: const Text("Copy URL"),
                                  avatar: const Icon(Icons.copy),
                                  onPressed: () {
                                    Clipboard.setData(
                                        ClipboardData(text: state.video!.url));
                                  },
                                ),
                                const SizedBox(width: 10),
                                ActionChip(
                                  label: const Text("Edit"),
                                  avatar: const Icon(Icons.edit),
                                  onPressed: () {
                                    AutoRouter.of(context).push(
                                      VideoEditRoute(
                                        videoId: state.video!.id,
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(width: 10),
                                DeleteActionChip(
                                  onDeleted: () {
                                    videoDetailBloc
                                        .add(const VideoDetailDelete());
                                  },
                                )
                              ],
                            ),
                          ),
                          // if (state.video != null)
                          //   MomentsSection(
                          //     // label: 'Moments of ${state.video!.name}',
                          //     ofVideo: state.video!.id,
                          //     onItemTap: (moment) {
                          //       _videoController?.seekTo(moment.startTime);
                          //     },
                          //   ),
                          if (state.video != null)
                            FiguresSection(
                              // label: 'Figures of ${state.video!.name}',
                              ofVideo: state.video!.id,
                            ),
                          if (state.video != null)
                            ArtistsSection(
                              label: 'Cast',
                              // label: 'Artists of ${state.video!.name}',
                              ofVideo: state.video!.id,
                            ),
                          if (state.video != null)
                            DancesSection(
                              // label: 'Dances of ${state.video!.name}',
                              ofVideo: state.video!.id,
                            ),
                          if (state.video != null)
                            EntityInfoListTile(
                              createdAt: state.video!.createdAt,
                              updateAt: state.video!.updatedAt,
                              version: state.video!.version,
                            ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
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
