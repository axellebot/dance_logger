import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class VideoListPage extends StatelessWidget
    implements AutoRouteWrapper, VideoListParams {
  /// Page params
  final bool showAppBar;

  /// ListBloc params
  final VideoListBloc? videoListBloc;

  /// VideoListParams
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  const VideoListPage({
    super.key,
    this.showAppBar = true,
    this.videoListBloc,

    /// VideoListParams
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
  });

  @override
  Widget build(BuildContext context) {
    final videoListBloc = BlocProvider.of<VideoListBloc>(context);

    return BlocBuilder<VideoListBloc, VideoListState>(
      builder: (context, state) {
        final PreferredSizeWidget? appBar;
        if (state.selectedVideos.isNotEmpty) {
          appBar = SelectingAppBar(
            count: state.selectedVideos.length,
            onCanceled: () {
              videoListBloc.add(const VideoListUnselect());
            },
            onDeleted: () {
              videoListBloc.add(const VideoListDelete());
            },
          );
        } else {
          appBar = (showAppBar)
              ? AppBar(
                  title: const Text('Videos'),
                )
              : null;
        }

        return Scaffold(
          appBar: appBar,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(VideoEditRoute());
            },
            child: const Icon(MdiIcons.plus),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              videoListBloc.add(const VideoListRefresh());
              return videoListBloc.stream
                  .firstWhere((e) => e.status != VideoListStatus.refreshing);
            },
            child: VideoListView(
              videoListBloc: videoListBloc,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return (videoListBloc != null)
        ? BlocProvider<VideoListBloc>.value(
            value: videoListBloc!,
            child: this,
          )
        : BlocProvider<VideoListBloc>(
            create: (context) => VideoListBloc(
              videoRepository:
                  Provider.of<VideoRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(VideoListLoad(
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofFigure: ofFigure,
              )),
            child: this,
          );
  }
}
