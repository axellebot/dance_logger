import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class FigureListPage extends StatelessWidget implements AutoRouteWrapper {
  final String? ofArtist;
  final String? ofDance;
  final String? ofVideo;
  final FigureListBloc? figureListBloc;

  const FigureListPage({
    super.key,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
    this.figureListBloc,
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Figures'),
      ),
      body: const FigureListView(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final repo = Provider.of<FigureRepository>(context, listen: false);
    if (figureListBloc != null) {
      return BlocProvider<FigureListBloc>.value(
        value: figureListBloc!,
        child: this,
      );
    } else {
      return BlocProvider<FigureListBloc>(
        create: (_) => FigureListBloc(
          figureRepository: repo,
          mapper: ModelMapper(),
        )..add(FigureListLoad(
            ofArtist: ofArtist,
            ofDance: ofDance,
            ofVideo: ofVideo,
          )),
        child: this,
      );
    }
  }
}
