import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ArtistListPage extends StatelessWidget implements ArtistListWidgetParams {
  /// Page params
  final bool showAppBar;

  /// ArtistListWidgetParams
  @override
  final ArtistListBloc? artistListBloc;
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

    /// ArtistListWidgetParams
    this.artistListBloc,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  }) : assert(artistListBloc == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return ArtistListBlocProvider(
      artistListBloc: artistListBloc,
      ofDance: ofDance,
      ofFigure: ofFigure,
      ofVideo: ofVideo,
      child: BlocBuilder<ArtistListBloc, ArtistListState>(
        builder: (context, state) {
          final artistListBloc = BlocProvider.of<ArtistListBloc>(context);
          final PreferredSizeWidget? appBar;
          if (state.selectedArtists.isNotEmpty) {
            appBar = SelectingAppBar(
              count: state.selectedArtists.length,
              onCanceled: () {
                artistListBloc.add(const ArtistListUnselect());
              },
              onDeleted: () {
                artistListBloc.add(const ArtistListDelete());
              },
            );
          } else {
            appBar = (showAppBar)
                ? const DanceAppBar(
                    title: Text('Artists'),
                  )
                : null;
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
