import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  final String figureId;

  const FigureDetailsPage({
    super.key,
    required this.figureId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FigureDetailBloc, FigureDetailState>(
      builder: (BuildContext context, FigureDetailState state) {
        switch (state.status) {
          case FigureDetailStatus.loading:
            return const LoadingPage();
          case FigureDetailStatus.success:
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    FigureEditRoute(
                      figureBloc: BlocProvider.of<FigureDetailBloc>(context),
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
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.fadeTitle,
                        StretchMode.blurBackground,
                        StretchMode.zoomBackground,
                      ],
                      title: Text(state.figure!.name),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        _buildArtistListView(),
                        _buildVideoListView(),
                        _buildPracticeListView(),
                        EntityInfoListTile(
                          createdAt: state.figure!.createdAt,
                          updateAt: state.figure!.updatedAt,
                          version: state.figure!.version,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case FigureDetailStatus.failure:
            return ErrorPage(error: state.error);
          default:
            return ErrorText(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }

  Widget _buildArtistListView() => BlocProvider<ArtistListBloc>(
        create: (context) => ArtistListBloc(
          artistRepository: RepositoryProvider.of<ArtistRepository>(context),
          mapper: ModelMapper(),
        )..add(ArtistListLoad(ofFigure: figureId)),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                SectionTile(
                  title: const Text('Artists'),
                  onTap: () {
                    AutoRouter.of(context).push(
                      ArtistListRoute(
                        ofFigure: figureId,
                        artistListBloc:
                            BlocProvider.of<ArtistListBloc>(context),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: AppStyles.cardHeight,
                  child: ArtistListView(
                    scrollDirection: Axis.horizontal,
                  ),
                )
              ],
            );
          },
        ),
      );

  Widget _buildVideoListView() => BlocProvider<VideoListBloc>(
        create: (context) => VideoListBloc(
          videoRepository: RepositoryProvider.of<VideoRepository>(context),
          mapper: ModelMapper(),
        )..add(VideoListLoad(ofFigure: figureId)),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                SectionTile(
                  title: const Text('Videos'),
                  onTap: () {
                    AutoRouter.of(context).push(
                      VideoListRoute(
                        ofFigure: figureId,
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
          },
        ),
      );

  Widget _buildPracticeListView() => BlocProvider<PracticeListBloc>(
        create: (context) => PracticeListBloc(
          practiceRepository:
              RepositoryProvider.of<PracticeRepository>(context),
          mapper: ModelMapper(),
        )..add(PracticeListLoad(ofFigure: figureId)),
        child: Builder(
          builder: (context) {
            return Column(
              children: [
                SectionTile(
                  title: const Text('Practices'),
                  onTap: () {
                    AutoRouter.of(context).push(
                      PracticeListRoute(
                        ofFigure: figureId,
                        practiceListBloc:
                            BlocProvider.of<PracticeListBloc>(context),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: AppStyles.cardHeight,
                  child: PracticeListView(
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            );
          },
        ),
      );

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<FigureDetailBloc>(
      create: (BuildContext context) {
        return FigureDetailBloc(
          figureRepository: RepositoryProvider.of<FigureRepository>(context),
          mapper: ModelMapper(),
        )..add(FigureDetailLoad(figureId: figureId));
      },
      child: this,
    );
  }
}

class FigureCreatePage extends StatelessWidget {
  const FigureCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Figure Create'),
    );
  }
}

class FigureEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final FigureDetailBloc? _figureBloc;
  late final String? _figureId;

  FigureEditPage({
    super.key,
    FigureDetailBloc? figureBloc,
    String? figureId,
  }) : assert(figureBloc != null || figureId != null, 'Either ') {
    _figureId = figureId;
    _figureBloc = figureBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Figure Edit'),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    if (_figureId != null) {
      return BlocProvider(
        create: (_) => FigureDetailBloc(
            figureRepository: RepositoryProvider.of<FigureRepository>(context),
            mapper: ModelMapper()),
        child: this,
      );
    } else if (_figureBloc != null) {
      return BlocProvider<FigureDetailBloc>.value(
        value: _figureBloc!,
        child: this,
      );
    }
    return this;
  }
}
