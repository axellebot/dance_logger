import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoListTile extends StatelessWidget {
  final VideoViewModel video;

  /// ListTile options
  final ItemCallback<VideoViewModel>? onTap;
  final ItemCallback<VideoViewModel>? onLongPress;
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
              tag: 'img-${video.id}',
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
      onLongPress: (onLongPress != null)
          ? () {
              onLongPress!(video);
            }
          : null,
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
    return GestureDetector(
      onTap: () {
        AutoRouter.of(context).push(
          VideoDetailsRoute(videoId: video.id),
        );
      },
      child: Column(
        children: [
          Expanded(
            child: Hero(
              tag: 'img-${video.id}',
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    AppStyles.videoListTileThumbnailRadius),
                child: Image.network(
                  'https://img.youtube.com/vi/${getYoutubeId(video.url)}/mqdefault.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Text(
            video.name,
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
                onChanged: (value) {
                  videoEditBloc.add(VideoEditChangeName(videoName: value));
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
                onChanged: (value) {
                  videoEditBloc.add(VideoEditChangeUrl(videoUrl: value));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
