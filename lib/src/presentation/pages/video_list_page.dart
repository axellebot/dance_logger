import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class VideoListPage extends StatelessWidget {
  final String _tag = '$VideoListPage';

  VideoListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<VideoViewModel> videos = [];
    return ListView.builder(
      itemCount: videos.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(videos[index].name),
        subtitle: Text(videos[index].url),
      ),
    );
  }
}
