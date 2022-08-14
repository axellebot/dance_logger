import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ArtistListPage extends StatelessWidget
    implements AutoRouteWrapper, ArtistListParams {
  final bool showAppBar;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;
  final ArtistListBloc? artistListBloc;

  const ArtistListPage({
    super.key,
    this.showAppBar = true,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  this.artistListBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: const Text('Artists'),
            )
          : null,
      body: const ArtistListView(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final repo = Provider.of<ArtistRepository>(context, listen: false);
    if (artistListBloc != null) {
      return BlocProvider<ArtistListBloc>.value(
        value: artistListBloc!,
        child: this,
      );
    } else {
      return BlocProvider<ArtistListBloc>(
        create: (_) => ArtistListBloc(
          artistRepository: repo,
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
}
