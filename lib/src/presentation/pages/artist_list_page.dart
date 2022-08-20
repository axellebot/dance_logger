import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ArtistListPage extends StatelessWidget
    implements EntityListPageParams, ArtistListWidgetParams {
  /// EntityListPageParams
  @override
  final bool showAppBar;
  @override
  final String? titleText;

  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
  @override
  final String? ofSearch;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const ArtistListPage({
    super.key,

    /// Page params
    this.showAppBar = true,
    this.titleText,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  }) : assert(artistListBloc == null ||
            ofSearch == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return ArtistListBlocProvider(
      artistListBloc: artistListBloc,
      ofSearch: ofSearch,
      ofDance: ofDance,
      ofFigure: ofFigure,
      ofVideo: ofVideo,
      child: BlocBuilder<ArtistListBloc, ArtistListState>(
        builder: (context, state) {
          final artistListBloc = BlocProvider.of<ArtistListBloc>(context);
          PreferredSizeWidget? appBar;
          if (showAppBar) {
            if (state.selectedArtists.isEmpty) {
              appBar = SearchAppBar(
                title:
                    (titleText != null) ? Text(titleText ?? 'Artists') : null,
                hintText: (titleText == null) ? 'Search artists' : null,
                onSearch: () {
                  showSearch(
                    context: context,
                    delegate: ArtistsSearchDelegate(
                      searchFieldLabel: 'Search artists',
                    ),
                  );
                },
              );
            } else {
              appBar = SelectionAppBar(
                count: state.selectedArtists.length,
                onCanceled: () {
                  artistListBloc.add(const ArtistListUnselect());
                },
                onDeleted: () {
                  artistListBloc.add(const ArtistListDelete());
                },
              );
            }
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(ArtistCreateRoute());
              },
              child: const Icon(MdiIcons.plus),
            ),
            body: RefreshIndicator(
              onRefresh: () {
                artistListBloc.add(const ArtistListRefresh());
                return artistListBloc.stream
                    .firstWhere((e) => e.status != ArtistListStatus.refreshing);
              },
              child: ArtistListView(
                artistListBloc: artistListBloc,
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
