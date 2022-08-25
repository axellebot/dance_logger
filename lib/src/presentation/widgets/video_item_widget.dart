import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoListTile extends StatelessWidget {
  final VideoViewModel video;

  /// ListTile options
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool selected;

  const VideoListTile({
    super.key,
    required this.video,

    /// ListTile options
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(video.name),
      leading: (isYoutube(video.url))
          ? Hero(
              tag: video.id,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    AppStyles.videoListTileThumbnailRadius),
                child: Image.network(
                  'https://img.youtube.com/vi/${getYoutubeId(video.url)}/mqdefault.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            )
          : null,
      subtitle: Text(video.url),
      onTap: () {
        AutoRouter.of(context).push(
          VideoDetailsRoute(videoId: video.id),
        );
      },
      onLongPress: onLongPress,
      selected: selected,
    );
  }
}

class CheckboxVideoListTile extends StatelessWidget {
  final VideoViewModel video;

  /// CheckboxLitTile options
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxVideoListTile({
    super.key,
    required this.video,

    /// CheckboxLitTile options
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(video.name),
      subtitle: Text(video.url),
      value: value,
      onChanged: onChanged,
    );
  }
}

class VideoCard extends StatelessWidget {
  final VideoViewModel video;

  const VideoCard({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppStyles.cardWidth,
      height: AppStyles.cardHeight,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: AppStyles.cardElevation,
        child: GestureDetector(
          onTap: () {
            AutoRouter.of(context).push(
              VideoDetailsRoute(videoId: video.id),
            );
          },
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Hero(
                tag: video.id,
                child: Image.network(
                  'https://img.youtube.com/vi/${getYoutubeId(video.url)}/mqdefault.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              _buildGradient(),
              _buildTitle(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGradient() {
    return Positioned.fill(
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [0.6, 0.95],
          ),
        ),
      ),
    );
  }

  Widget _buildTitle() {
    return Positioned(
      left: 5,
      bottom: 5,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            video.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class VideoForm extends StatelessWidget {
  const VideoForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final VideoEditBloc videoEditBloc = BlocProvider.of<VideoEditBloc>(context);
    return BlocBuilder<VideoEditBloc, VideoEditState>(
      builder: (BuildContext context, VideoEditState state) {
        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Best video ever',
                ),
                initialValue: state.initialVideo?.name,
                onChanged: (videoName) {
                  videoEditBloc.add(VideoEditChangeName(videoName: videoName));
                },
              ),
              const SizedBox(
                height: AppStyles.formInputVerticalSpacing,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Url',
                  hintText: 'https://youtu.be/qwerty',
                ),
                initialValue: state.initialVideo?.url,
                onChanged: (videoUrl) {
                  videoEditBloc.add(VideoEditChangeUrl(videoUrl: videoUrl));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
