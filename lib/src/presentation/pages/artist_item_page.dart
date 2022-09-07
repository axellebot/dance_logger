import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ArtistDetailsPage extends StatefulWidget implements AutoRouteWrapper {
  final String artistId;

  const ArtistDetailsPage({
    super.key,
    required this.artistId,
  });

  @override
  State<ArtistDetailsPage> createState() => _ArtistDetailsPageState();

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

class _ArtistDetailsPageState extends State<ArtistDetailsPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ArtistDetailBloc, ArtistDetailState>(
      listener: (context, state) {
        switch (state.status) {
          case ArtistDetailStatus.refreshingSuccess:
            _refreshController.refreshCompleted();
            break;
          case ArtistDetailStatus.refreshingFailure:
            _refreshController.refreshFailed();
            break;
          default:
        }
      },
      child: BlocBuilder<ArtistDetailBloc, ArtistDetailState>(
        builder: (BuildContext context, ArtistDetailState state) {
          final ArtistDetailBloc artistDetailBloc =
              BlocProvider.of<ArtistDetailBloc>(context);
          Widget? background = (state.artist?.imageUrl != null)
              ? Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Hero(
                      tag: state.artist!.id,
                      child: Image.network(
                        state.artist!.imageUrl!,
                        fit: BoxFit.cover,
                      ),
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
                  expandedHeight: MediaQuery.of(context).size.height * 0.3,
                  stretch: true,
                  flexibleSpace: FlexibleSpaceBar(
                    stretchModes: const [
                      StretchMode.fadeTitle,
                      StretchMode.blurBackground,
                      StretchMode.zoomBackground,
                    ],
                    title: (state.artist != null)
                        ? Text(state.artist!.name)
                        : const Text('Artist detail'),
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
                SliverFillRemaining(
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    onRefresh: () {
                      artistDetailBloc.add(const ArtistDetailRefresh());
                    },
                    child: ListView(
                      children: <Widget>[
                        if (state.artist != null)
                          DancesSection(
                            // label: 'Dances of ${state.artist!.name}',
                            ofArtist: state.artist!.id,
                          ),
                        if (state.artist != null)
                          FiguresSection(
                            // label: 'Figures of ${state.artist!.name}',
                            ofArtist: state.artist!.id,
                          ),
                        if (state.artist != null)
                          VideosSection(
                            // label: 'Videos of ${state.artist!.name}',
                            ofArtist: state.artist!.id,
                          ),
                        if (state.artist != null)
                          EntityInfoListTile(
                            createdAt: state.artist!.createdAt,
                            updateAt: state.artist!.updatedAt,
                            version: state.artist!.version,
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
}

class ArtistCreatePage extends ArtistEditPage {
  const ArtistCreatePage({super.key});
}

class ArtistEditPage extends StatelessWidget implements AutoRouteWrapper {
  final String? artistId;

  const ArtistEditPage({
    super.key,
    this.artistId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ArtistEditBloc, ArtistEditState>(
      builder: (context, state) {
        switch (state.status) {
          case ArtistEditStatus.initial:
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
      )..add(ArtistEditStart(artistId: artistId)),
      child: this,
    );
  }
}
