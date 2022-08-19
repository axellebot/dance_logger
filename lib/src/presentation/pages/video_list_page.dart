import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VideoListPage extends StatelessWidget implements VideoListWidgetParams {
  /// Page params
  final bool showAppBar;

  /// VideoListWidgetParams
  @override
  final VideoListBloc? videoListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  const VideoListPage({
    super.key,
    this.showAppBar = true,

    /// VideoListWidgetParams
    this.videoListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
  }) : assert(videoListBloc == null ||
            (ofArtist == null && ofDance == null && ofFigure == null));

  @override
  Widget build(BuildContext context) {
    return VideoListBlocProvider(
      videoListBloc: videoListBloc,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofFigure: ofFigure,
      child: BlocBuilder<VideoListBloc, VideoListState>(
        builder: (context, state) {
          final videoListBloc = BlocProvider.of<VideoListBloc>(context);
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
                ? const DanceAppBar(
                    title: Text('Videos'),
                  )
                : null;
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(VideoCreateRoute());
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
      ),
    );
  }
}
