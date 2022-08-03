import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanceDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  final String danceId;

  const DanceDetailsPage({
    super.key,
    required this.danceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanceDetailBloc, DanceDetailState>(
      builder: (BuildContext context, DanceDetailState state) {
        switch (state.status) {
          case DanceDetailStatus.loading:
            return const LoadingPage();
          case DanceDetailStatus.success:
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () => AutoRouter.of(context).push(
                  DanceEditRoute(
                    danceId: state.dance!.id,
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
                    title: Text(state.dance!.name),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        _buildArtistsSection(),
                        _buildFiguresSection(),
                        _buildVideosSection(),
                        EntityInfoListTile(
                          createdAt: state.dance!.createdAt,
                          updateAt: state.dance!.updatedAt,
                          version: state.dance!.version,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case DanceDetailStatus.failure:
            return ErrorPage(error: state.error);
          default:
            return ErrorText(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }

  Widget _buildArtistsSection() => BlocProvider<ArtistListBloc>(
        create: (context) => ArtistListBloc(
          artistRepository: RepositoryProvider.of<ArtistRepository>(context),
          mapper: ModelMapper(),
        )..add(ArtistListLoad(ofDance: danceId)),
        child: Builder(builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: const Text('Artists'),
                onTap: () => AutoRouter.of(context).push(
                  ArtistListRoute(
                    ofDance: danceId,
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

  Widget _buildFiguresSection() => BlocProvider<FigureListBloc>(
        create: (context) => FigureListBloc(
          figureRepository: RepositoryProvider.of<FigureRepository>(context),
          mapper: ModelMapper(),
        )..add(FigureListLoad(ofDance: danceId)),
        child: Builder(builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: const Text('Figures'),
                onTap: () => AutoRouter.of(context).push(
                  FigureListRoute(
                    ofDance: danceId,
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

  Widget _buildVideosSection() => BlocProvider<VideoListBloc>(
        create: (context) => VideoListBloc(
          videoRepository: RepositoryProvider.of<VideoRepository>(context),
          mapper: ModelMapper(),
        )..add(VideoListLoad(ofDance: danceId)),
        child: Builder(builder: (context) {
          return Column(
            children: [
              SectionTile(
                title: const Text('Videos'),
                onTap: () => AutoRouter.of(context).push(
                  VideoListRoute(
                    ofDance: danceId,
                    videoListBloc: BlocProvider.of<VideoListBloc>(context),
                  ),
                ),
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
    return BlocProvider<DanceDetailBloc>(
      create: (BuildContext context) {
        return DanceDetailBloc(
          danceRepository: RepositoryProvider.of<DanceRepository>(context),
          mapper: ModelMapper(),
        )..add(DanceDetailLoad(danceId: danceId));
      },
      child: this,
    );
  }
}

class DanceCreatePage extends DanceEditPage {
  DanceCreatePage({super.key});
}

class DanceEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final String? _danceId;

  DanceEditPage({
    super.key,
    String? danceId,
  }) {
    _danceId = danceId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text(_danceId != null ? "Edit Dance" : "Create Dance")),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Dance Edit'),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => DanceEditBloc(
        danceRepository: RepositoryProvider.of<DanceRepository>(context),
        mapper: ModelMapper(),
      )..add(DanceEditStart(danceId: _danceId)),
      child: this,
    );
  }
}
