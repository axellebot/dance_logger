import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ArtistDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  final String artistId;

  const ArtistDetailsPage({
    super.key,
    required this.artistId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistBloc, ArtistDetailState>(
      builder: (BuildContext context, ArtistDetailState state) {
        switch (state.status) {
          case ArtistDetailStatus.loading:
            return const LoadingPage();
          case ArtistDetailStatus.success:
            Widget? background = (state.artist!.imageUrl != null)
                ? Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Image.network(
                        state.artist!.imageUrl!,
                        fit: BoxFit.cover,
                      ),
                      _buildGradient(),
                    ],
                  )
                : null;
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    ArtistEditRoute(
                      artistId: state.artist!.id,
                    ),
                  );
                },
                child: const Icon(Icons.edit),
              ),
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 320.0,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.fadeTitle,
                        StretchMode.blurBackground,
                        StretchMode.zoomBackground,
                      ],
                      title: Text(state.artist!.name),
                      background: background,
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        _buildFiguresSection(),
                        _buildVideosSection(),
                        EntityInfoListTile(
                          createdAt: state.artist!.createdAt,
                          updateAt: state.artist!.updatedAt,
                          version: state.artist!.version,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case ArtistDetailStatus.failure:
            return ErrorPage(error: state.error!);
          default:
            return ErrorText(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }

  Widget _buildFiguresSection() => BlocProvider<FigureListBloc>(
        create: (context) => FigureListBloc(
          figureRepository: RepositoryProvider.of<FigureRepository>(context),
          mapper: ModelMapper(),
        )..add(FigureListLoad(ofArtist: artistId)),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                SectionTile(
                  title: const Text('Figures'),
                  onTap: () {
                    AutoRouter.of(context).push(
                      FigureListRoute(
                        ofArtist: artistId,
                        figureListBloc:
                            BlocProvider.of<FigureListBloc>(context),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: AppStyles.cardHeight,
                  child: FigureListView(
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            );
          },
        ),
      );

  Widget _buildVideosSection() => BlocProvider<VideoListBloc>(
        create: (context) => VideoListBloc(
          videoRepository: RepositoryProvider.of<VideoRepository>(context),
          mapper: ModelMapper(),
        )..add(VideoListLoad(ofArtist: artistId)),
        child: Builder(builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: const Text('Videos'),
                onTap: () {
                  AutoRouter.of(context).push(
                    VideoListRoute(
                      ofArtist: artistId,
                      videoListBloc: BlocProvider.of<VideoListBloc>(context),
                    ),
                  );
                },
              ),
              const SizedBox(
                height: AppStyles.cardHeight,
                child: VideoListView(
                  scrollDirection: Axis.horizontal,
                ),
              ),
            ],
          );
        }),
      );

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<ArtistBloc>(
      create: (BuildContext context) {
        return ArtistBloc(
          artistRepository: RepositoryProvider.of<ArtistRepository>(context),
          mapper: ModelMapper(),
        )..add(ArtistLoad(artistId: artistId));
      },
      child: this,
    );
  }
}

class ArtistCreatePage extends ArtistEditPage {
  ArtistCreatePage({super.key});
}

class ArtistEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final String? _artistId;

  ArtistEditPage({
    super.key,
    String? artistId,
  }) {
    _artistId = artistId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_artistId != null ? "Edit Artist" : "New Artist"),
      ),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Artist Edit'),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => ArtistBloc(
        artistRepository: RepositoryProvider.of<ArtistRepository>(context),
        mapper: ModelMapper(),
      )
      // TODO: Add event to load model
      // ..add()
      ,
      child: this,
    );
  }
}
