import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
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

  @override
  void initState() {
    super.initState();
  }

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
      child: BlocBuilder<VideoDetailBloc, VideoDetailState>(
        builder: (BuildContext context, VideoDetailState state) {
          switch (state.status) {
            case VideoDetailStatus.initial:
            case VideoDetailStatus.loading:
              return const LoadingPage();
            case VideoDetailStatus.detailSuccess:
            case VideoDetailStatus.refreshing:
              final VideoDetailBloc videoDetailBloc =
                  BlocProvider.of<VideoDetailBloc>(context);
              return Scaffold(
                body: RefreshIndicator(
                  edgeOffset:
                      kToolbarHeight + MediaQuery.of(context).viewPadding.top,
                  onRefresh: () {
                    videoDetailBloc.add(const VideoDetailRefresh());
                    return videoDetailBloc.stream.firstWhere(
                        (e) => e.status != VideoListStatus.refreshing);
                  },
                  child: CustomScrollView(
                    slivers: <Widget>[
                      SliverAppBar(
                        pinned: true,
                        snap: false,
                        floating: false,
                        title: Text(state.video!.name),
                        actions: [
                          IconButton(
                            onPressed: () {
                              AutoRouter.of(context).push(
                                VideoEditRoute(
                                  videoId: state.video!.id,
                                ),
                              );
                            },
                            icon: const Icon(Icons.edit),
                          ),
                          DeleteIconButton(
                            onDeleted: () {
                              videoDetailBloc.add(const VideoDetailDelete());
                            },
                          )
                        ],
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          <Widget>[
                            if (_videoController != null)
                              AspectRatio(
                                aspectRatio: 16 / 9,
                                child: YoutubePlayer(
                                  controller: _videoController!,
                                ),
                              ),
                            ListTile(
                                title: Text(state.video!.url),
                                trailing: const Icon(MdiIcons.contentCopy),
                                onTap: () {
                                  Clipboard.setData(
                                      ClipboardData(text: state.video!.url));
                                }),
                            MomentsSection(
                              // label: 'Moments of ${state.video!.name}',
                              ofVideo: state.video!.id,
                              onItemTap: (moment) {
                                _videoController?.seekTo(moment.startTime);
                              },
                            ),
                            FiguresSection(
                              // label: 'Figures of ${state.video!.name}',
                              ofVideo: state.video!.id,
                            ),
                            ArtistsSection(
                              // label: 'Artists of ${state.video!.name}',
                              ofVideo: state.video!.id,
                            ),
                            DancesSection(
                              // label: 'Dances of ${state.video!.name}',
                              ofVideo: state.video!.id,
                            ),
                            EntityInfoListTile(
                              createdAt: state.video!.createdAt,
                              updateAt: state.video!.updatedAt,
                              version: state.video!.version,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            case VideoDetailStatus.failure:
              return ErrorPage(error: state.error);
            default:
              return ErrorPage(
                error: NotSupportedError(message: '${state.status}'),
              );
          }
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
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }
}

class VideoCreatePage extends VideoEditPage {
  VideoCreatePage({super.key});
}

/// TODO : Force name and url
class VideoEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final String? _videoId;

  VideoEditPage({
    super.key,
    String? videoId,
  }) {
    _videoId = videoId;
  }

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
      )..add(VideoEditStart(videoId: _videoId)),
      child: this,
    );
  }
}
