import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class VideoListPage extends StatelessWidget implements AutoRouteWrapper {
  final String? ofArtist;
  final String? ofDance;
  final String? ofFigure;
  final VideoListBloc? videoListBloc;

  const VideoListPage({
    super.key,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.videoListBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos'),
      ),
      body: const VideoListView(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final repo = Provider.of<VideoRepository>(context, listen: false);
    if (videoListBloc != null) {
      return BlocProvider<VideoListBloc>.value(
        value: videoListBloc!,
        child: this,
      );
    } else {
      return BlocProvider<VideoListBloc>(
        create: (_) => VideoListBloc(
          videoRepository: repo,
          mapper: ModelMapper(),
        )..add(VideoListLoad(
            ofArtist: ofArtist,
            ofDance: ofDance,
            ofFigure: ofFigure,
          )),
        child: this,
      );
    }
  }
}
