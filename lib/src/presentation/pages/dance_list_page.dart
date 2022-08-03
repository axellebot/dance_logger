import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:dance/domain.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class DanceListPage extends StatelessWidget implements AutoRouteWrapper {
  final String? ofArtist;
  final String? ofFigure;
  final String? ofVideo;
  final DanceListBloc? danceListBloc;

  const DanceListPage({
    super.key,
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
    this.danceListBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dances'),
      ),
      body: const DanceListView(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final repo = Provider.of<DanceRepository>(context, listen: false);
    if (danceListBloc != null) {
      return BlocProvider<DanceListBloc>.value(
        value: danceListBloc!,
        child: this,
      );
    } else {
      return BlocProvider<DanceListBloc>(
        create: (_) => DanceListBloc(
          danceRepository: repo,
          mapper: ModelMapper(),
        )..add(DanceListLoad(
            ofArtist: ofArtist,
            ofFigure: ofFigure,
            ofVideo: ofVideo,
          )),
        child: this,
      );
    }
  }
}
