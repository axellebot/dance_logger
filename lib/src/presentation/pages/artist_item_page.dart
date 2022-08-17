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
    return BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
      builder: (BuildContext context, ArtistDetailState state) {
        switch (state.status) {
          case ArtistDetailStatus.loading:
            return const LoadingPage();
          case ArtistDetailStatus.detailSuccess:
            final ArtistDetailBloc artistDetailBloc =
                BlocProvider.of<ArtistDetailBloc>(context);
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
                    actions: [
                      IconButton(
                        onPressed: () {
                          AutoRouter.of(context).push(
                            ArtistEditRoute(
                              artistId: state.artist!.id,
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      DeleteIconButton(
                        onDeleted: () {
                          artistDetailBloc.add(const ArtistDetailDelete());
                        },
                      )
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        FiguresSection(ofArtist: artistId),
                        VideosSection(ofArtist: artistId),
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
            return ErrorPage(error: state.error);
          default:
            return ErrorPage(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }

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
    return BlocProvider<ArtistDetailBloc>(
      create: (BuildContext context) {
        return ArtistDetailBloc(
          artistRepository: RepositoryProvider.of<ArtistRepository>(context),
          mapper: ModelMapper(),
        )..add(ArtistDetailLoad(artistId: artistId));
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
    return BlocBuilder<ArtistEditBloc, ArtistEditState>(
      builder: (context, state) {
        switch (state.status) {
          case ArtistEditStatus.loading:
            return const LoadingPage();
          case ArtistEditStatus.failure:
            return ErrorPage(error: state.error!);
          case ArtistEditStatus.ready:
          case ArtistEditStatus.editSuccess:
            final artistEditBloc = BlocProvider.of<ArtistEditBloc>(context);
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
                title: Text(
                  state.initialArtist != null ? "Edit artist" : "Create artist",
                ),
                actions: <Widget>[
                  SaveButton(
                    onSaved: () {
                      artistEditBloc.add(const ArtistEditSubmit());
                    },
                  ),
                  if (state.initialArtist != null)
                    DeleteIconButton(
                      onDeleted: () {
                        artistEditBloc.add(const ArtistEditDelete());
                      },
                    ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: AppStyles.formPadding,
                  child: const ArtistForm(),
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
      create: (_) => ArtistEditBloc(
        artistRepository: RepositoryProvider.of<ArtistRepository>(context),
        mapper: ModelMapper(),
      )..add(ArtistEditStart(artistId: _artistId)),
      child: this,
    );
  }
}
