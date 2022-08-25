import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class VideoListPage extends StatelessWidget
    implements EntityListPageParams, VideoListWidgetParams {
  /// EntityListPageParams
  @override
  final bool showAppBar;
  @override
  final String? titleText;

  /// VideoListWidgetParams
  @override
  final VideoListBloc? videoListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  const VideoListPage({
    super.key,
    this.showAppBar = true,
    this.titleText,

    /// VideoListWidgetParams
    this.videoListBloc,
    this.ofSearch,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
  }) : assert(videoListBloc == null ||
            ofSearch == null ||
            (ofArtist == null && ofDance == null && ofFigure == null));

  @override
  Widget build(BuildContext context) {
    return VideoListBlocProvider(
      videoListBloc: videoListBloc,
      ofSearch: ofSearch,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofFigure: ofFigure,
      child: BlocBuilder<VideoListBloc, VideoListState>(
        builder: (context, state) {
          final videoListBloc = BlocProvider.of<VideoListBloc>(context);
          PreferredSizeWidget? appBar;
          if (showAppBar) {
            if (state.selectedVideos.isEmpty) {
              appBar = SearchAppBar(
                title: (titleText != null) ? Text(titleText ?? 'Videos') : null,
                hintText: (titleText == null) ? 'Search videos' : null,
                onSearch: () {
                  showSearch(
                    context: context,
                    delegate: VideosSearchDelegate(
                      searchFieldLabel: 'Search videos',
                    ),
                  );
                },
              );
            } else {
              appBar = SelectionAppBar(
                count: state.selectedVideos.length,
                onCanceled: () {
                  videoListBloc.add(const VideoListUnselect());
                },
                onDeleted: () {
                  videoListBloc.add(const VideoListDelete());
                },
              );
            }
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(VideoCreateRoute());
              },
              child: const Icon(MdiIcons.plus),
            ),
            body: VideoListView(
              videoListBloc: videoListBloc,
              scrollDirection: Axis.vertical,
            ),
          );
        },
      ),
    );
  }
}
