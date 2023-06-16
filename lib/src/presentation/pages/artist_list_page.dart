import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@RoutePage<List<ArtistViewModel>>()
class ArtistListPage extends StatelessWidget
    implements EntityListPageParams<ArtistViewModel>, ArtistListWidgetParams {
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
  final List<ArtistViewModel>? preselectedItems;

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
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  })  : assert(shouldSelectOne == false || shouldSelectMultiple == false),
        assert(artistListBloc == null ||
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
      preselectedArtists: preselectedItems,
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
                onDeleted: (state.selectedArtists.isNotEmpty)
                    ? () {
                        artistListBloc.add(const ArtistListDelete());
                      }
                    : null,
                onConfirmed: (state.selectedArtists.isNotEmpty &&
                        shouldSelectMultiple)
                    ? () {
                        AutoRouter.of(context)
                            .pop<List<ArtistViewModel>>(state.selectedArtists);
                      }
                    : null,
              );
            }
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(const ArtistCreateRoute());
              },
              child: Icon(MdiIcons.plus),
            ),
            body: ArtistListView(
              artistListBloc: artistListBloc,
              scrollDirection: Axis.vertical,
            ),
          );
        },
      ),
    );
  }
}
