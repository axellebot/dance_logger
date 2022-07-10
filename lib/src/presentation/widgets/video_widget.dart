import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class VideoItemTile extends StatelessWidget {
  final VideoViewModel video;

  const VideoItemTile({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(video.name),
      subtitle: Text(video.url),
      onTap: () => AutoRouter.of(context).push(
        VideoDetailsRoute(videoId: video.id),
      ),
    );
  }
}

class VideoItemCard extends StatelessWidget {
  final VideoViewModel video;

  const VideoItemCard({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppStyles.cardWidth,
      height: AppStyles.cardHeight,
      child: GestureDetector(
        // onTap: () => AutoRouter.of(context).push(
        //   VideoDetailsRoute(videoId: video.id),
        // ),
        child: Card(
          elevation: AppStyles.cardElevation,
          child: Container(
            padding: AppStyles.cardPadding,
            child: Text(video.name),
          ),
        ),
      ),
    );
  }
}
