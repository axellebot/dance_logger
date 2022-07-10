import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:dance/src/presentation/widgets/entity_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  final String videoId;

  const VideoDetailsPage({
    super.key,
    required this.videoId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideoBloc, VideoState>(
      builder: (BuildContext context, VideoState state) {
        if (state is VideoLoading) {
          return const LoadingPage();
        } else if (state is VideoLoaded) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => AutoRouter.of(context).push(
                VideoEditRoute(
                  videoBloc: BlocProvider.of<VideoBloc>(context),
                ),
              ),
              child: const Icon(Icons.edit),
            ),
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: false,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.fadeTitle,
                      StretchMode.blurBackground,
                      StretchMode.zoomBackground,
                    ],
                    title: Text(state.video.name),
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SizedBox(
                        height: AppStyles.cardHeight,
                        child: _buildFigureList(),
                      ),
                      EntityInfoListTile(
                        createdAt: state.video.createdAt.toLocal().toString(),
                        updateAt: state.video.updatedAt.toLocal().toString(),
                        version: state.video.version.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is VideoFailed) {
          return ErrorPage(error: state.error);
        }
        return ErrorText(
          error: NotSupportedError(message: '${state.runtimeType}'),
        );
      },
    );
  }

  Widget _buildFigureList() => BlocProvider<FigureListBloc>(
        create: (context) => FigureListBloc(
          figureRepository: RepositoryProvider.of<FigureRepository>(context),
          mapper: ModelMapper(),
        )..add(FigureListLoad(ofVideo: videoId)),
        child: const FigureListView(
          scrollDirection: Axis.horizontal,
        ),
      );

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<VideoBloc>(
      create: (BuildContext context) {
        return VideoBloc(
          videoRepository: RepositoryProvider.of<VideoRepository>(context),
          mapper: ModelMapper(),
        )..add(VideoLoad(videoId: videoId));
      },
      child: this,
    );
  }
}

class VideoCreatePage extends StatelessWidget {
  const VideoCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Video Create'),
    );
  }
}

class VideoEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final VideoBloc? _videoBloc;
  late final String? _videoId;

  VideoEditPage({
    super.key,
    VideoBloc? videoBloc,
    String? videoId,
  }) : assert(videoBloc != null || videoId != null, 'Either ') {
    _videoId = videoId;
    _videoBloc = videoBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Video Edit'),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    if (_videoId != null) {
      return BlocProvider(
        create: (_) => VideoBloc(
            videoRepository: RepositoryProvider.of<VideoRepository>(context),
            mapper: ModelMapper()),
        child: this,
      );
    } else if (_videoBloc != null) {
      return BlocProvider<VideoBloc>.value(
        value: _videoBloc!,
        child: this,
      );
    }
    return this;
  }
}
