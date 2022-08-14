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
      leading: _buildVideoThumbnail(),
      subtitle: Text(video.url),
      onTap: () {
        AutoRouter.of(context).push(
          VideoDetailsRoute(videoId: video.id),
        );
      },
    );
  }

  ClipRRect? _buildVideoThumbnail() {
    return (isYoutube(video.url))
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              'https://img.youtube.com/vi/${getYoutubeId(video.url)}/mqdefault.jpg',
              fit: BoxFit.cover,
            ),
          )
        : null;
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
      child: Card(
        elevation: AppStyles.cardElevation,
        child: GestureDetector(
          onTap: () => AutoRouter.of(context).push(
            VideoDetailsRoute(videoId: video.id),
          ),
          child: Container(
            padding: AppStyles.cardPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(video.name),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
