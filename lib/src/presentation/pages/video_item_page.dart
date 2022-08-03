import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
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
    return BlocBuilder<VideoDetailBloc, VideoDetailState>(
      builder: (BuildContext context, VideoDetailState state) {
        switch (state.status) {
          case VideoDetailStatus.loading:
            return const LoadingPage();
          case VideoDetailStatus.success:
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => AutoRouter.of(context).push(
                  VideoEditRoute(
                    videoId: state.video!.id,
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
                      title: Text(state.video!.name),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        if (isYoutube(state.video!.url))
                          Text('${getYoutubeId(state.video!.url)}'),
                        _buildFiguresSection(),
                        _buildArtistsSection(),
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
            );
          case VideoDetailStatus.failure:
            return ErrorPage(error: state.error);
          default:
            return ErrorText(
              error: NotSupportedError(message: '${state.runtimeType}'),
            );
        }
      },
    );
  }

  Widget _buildFiguresSection() => BlocProvider<FigureListBloc>(
        create: (context) => FigureListBloc(
          figureRepository: RepositoryProvider.of<FigureRepository>(context),
          mapper: ModelMapper(),
        )..add(FigureListLoad(ofVideo: videoId)),
        child: Builder(builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionTile(
                title: const Text('Figures'),
                onTap: () => AutoRouter.of(context).push(
                  FigureListRoute(
                    ofVideo: videoId,
                    figureListBloc: BlocProvider.of<FigureListBloc>(context),
                  ),
                ),
              ),
              const SizedBox(
                height: AppStyles.cardHeight,
                child: FigureListView(
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        }),
      );

  Widget _buildArtistsSection() => BlocProvider<ArtistListBloc>(
        create: (context) => ArtistListBloc(
          artistRepository: RepositoryProvider.of<ArtistRepository>(context),
          mapper: ModelMapper(),
        )..add(ArtistListLoad(ofVideo: videoId)),
        child: Builder(builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: const Text('Artists'),
                onTap: () => AutoRouter.of(context).push(
                  ArtistListRoute(
                    ofVideo: videoId,
                    artistListBloc: BlocProvider.of<ArtistListBloc>(context),
                  ),
                ),
              ),
              const SizedBox(
                height: AppStyles.cardHeight,
                child: ArtistListView(
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        }),
      );

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

class VideoCreatePage extends VideoEditPage {
  VideoCreatePage({super.key});
}

class VideoEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final VideoDetailBloc? _videoBloc;
  late final String? _videoId;

  VideoEditPage({
    super.key,
    String? videoId,
  }) {
    _videoId = videoId;
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
    return BlocProvider(
      create: (_) => VideoDetailBloc(
          videoRepository: RepositoryProvider.of<VideoRepository>(context),
          mapper: ModelMapper()),
      child: this,
    );
  }
}
