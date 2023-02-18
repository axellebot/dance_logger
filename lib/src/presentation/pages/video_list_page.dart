import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@RoutePage<List<VideoViewModel>>()
class VideoListPage extends StatelessWidget
    implements EntityListPageParams, VideoListWidgetParams {
  /// EntityListPageParams
  @override
  final bool showAppBar;
  @override
  final String? titleText;
  @override
  final bool shouldSelectOne;
  @override
  final bool shouldSelectMultiple;
  @override
  final List<VideoViewModel>? preselectedItems;

  /// VideoListWidgetParams
  @override
  final VideoListBloc? videoListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofFigureId;

  const VideoListPage({
    super.key,
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,

    /// VideoListWidgetParams
    this.videoListBloc,
    this.ofSearch,
    this.ofArtistId,
    this.ofDanceId,
    this.ofFigureId,
  })  : assert(shouldSelectOne == false || shouldSelectMultiple == false),
        assert(videoListBloc == null ||
            ofSearch == null ||
            (ofArtistId == null && ofDanceId == null && ofFigureId == null));

  @override
  Widget build(BuildContext context) {
    return VideoListBlocProvider(
      videoListBloc: videoListBloc,
      ofSearch: ofSearch,
      ofArtistId: ofArtistId,
      ofDanceId: ofDanceId,
      ofFigureId: ofFigureId,
      preselectedVideos: preselectedItems,
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
                onDeleted: (state.selectedVideos.isNotEmpty)
                    ? () {
                        videoListBloc.add(const VideoListDelete());
                      }
                    : null,
                onConfirmed: (state.selectedVideos.isNotEmpty &&
                        shouldSelectMultiple)
                    ? () {
                        AutoRouter.of(context)
                            .pop<List<VideoViewModel>>(state.selectedVideos);
                      }
                    : null,
              );
            }
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(const VideoCreateRoute());
              },
              child: Icon(MdiIcons.plus),
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
