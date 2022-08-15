import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
          case VideoDetailStatus.detailSuccess:
            final VideoDetailBloc videoDetailBloc =
                BlocProvider.of<VideoDetailBloc>(context);
            return Scaffold(
              body: CustomScrollView(
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
                        ListTile(
                            title: Text(state.video!.url),
                            trailing: const Icon(MdiIcons.contentCopy),
                            onTap: () {
                              Clipboard.setData(
                                  ClipboardData(text: state.video!.url));
                            }),
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
            return ErrorPage(
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
        )..add(FigureListLoad(ofVideo: videoId)),
        child: Builder(builder: (context) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SectionTile(
                title: const Text('Figures'),
                onTap: () {
                  AutoRouter.of(context).push(
                    FigureListRoute(
                      ofVideo: videoId,
                      figureListBloc: BlocProvider.of<FigureListBloc>(context),
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
                  child: VideoForm(),
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
