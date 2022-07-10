import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:dance/src/presentation/widgets/entity_widget.dart';
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
    return BlocBuilder<ArtistBloc, ArtistState>(
      builder: (BuildContext context, ArtistState state) {
        if (state is ArtistLoading) {
          return const LoadingPage();
        } else if (state is ArtistLoaded) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () => AutoRouter.of(context).push(
                ArtistEditRoute(
                  artistBloc: BlocProvider.of<ArtistBloc>(context),
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
                  expandedHeight: 320.0,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.fadeTitle,
                      StretchMode.blurBackground,
                      StretchMode.zoomBackground,
                    ],
                    title: Text(state.artist.name),
                    background: state.artist.imageUrl != null
                        ? Image.network(
                            state.artist.imageUrl!,
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[
                      SizedBox(
                        height: AppStyles.cardHeight,
                        child: _buildFigureListView(),
                      ),
                      EntityInfoListTile(
                        createdAt: state.artist.createdAt.toLocal().toString(),
                        updateAt: state.artist.updatedAt.toLocal().toString(),
                        version: state.artist.version.toString(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else if (state is ArtistFailed) {
          return ErrorPage(error: state.error);
        }
        return ErrorText(
          error: NotSupportedError(message: '${state.runtimeType}'),
        );
      },
    );
  }

  Widget _buildFigureListView() => BlocProvider<FigureListBloc>(
        create: (context) => FigureListBloc(
          figureRepository: RepositoryProvider.of<FigureRepository>(context),
          mapper: ModelMapper(),
        )..add(FigureListLoad(ofArtist: artistId)),
        child: const FigureListView(
          scrollDirection: Axis.horizontal,
        ),
      );

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

class ArtistCreatePage extends StatelessWidget {
  const ArtistCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Artist Create'),
    );
  }
}

class ArtistEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final ArtistBloc? _artistBloc;
  late final String? _artistId;

  ArtistEditPage({
    super.key,
    ArtistBloc? artistBloc,
    String? artistId,
  }) : assert(artistBloc != null || artistId != null, 'Either ') {
    _artistId = artistId;
    _artistBloc = artistBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Artist Edit'),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    if (_artistId != null) {
      return BlocProvider(
        create: (_) => ArtistBloc(
            artistRepository: RepositoryProvider.of<ArtistRepository>(context),
            mapper: ModelMapper()),
        child: this,
      );
    } else if (_artistBloc != null) {
      return BlocProvider<ArtistBloc>.value(
        value: _artistBloc!,
        child: this,
      );
    }
    return this;
  }
}
