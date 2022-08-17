import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class ArtistListPage extends StatelessWidget
    implements AutoRouteWrapper, ArtistListParams {
  /// Page params
  final bool showAppBar;

  /// ListBloc params
  final ArtistListBloc? artistListBloc;

  /// ArtistListParams
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

    /// ListBloc params
    this.artistListBloc,

    /// ArtistListParams
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    final artistListBloc = BlocProvider.of<ArtistListBloc>(context);

    return BlocBuilder<ArtistListBloc, ArtistListState>(
      builder: (context, state) {
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
              ? AppBar(
                  title: const Text('Artists'),
                )
              : null;
        }

        return Scaffold(
          appBar: appBar,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(ArtistEditRoute());
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
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return (artistListBloc != null)
        ? BlocProvider<ArtistListBloc>.value(
            value: artistListBloc!,
            child: this,
          )
        : BlocProvider<ArtistListBloc>(
            create: (_) => ArtistListBloc(
              artistRepository:
                  Provider.of<ArtistRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(ArtistListLoad(
                ofDance: ofDance,
                ofFigure: ofFigure,
                ofVideo: ofVideo,
              )),
            child: this,
          );
  }
}
