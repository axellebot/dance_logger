import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class VideoDetailWidgetParams implements VideoDetailParams {
  final VideoDetailBloc? videoDetailBloc;
  final VideoViewModel? ofVideo;

  VideoDetailWidgetParams(this.videoDetailBloc, this.ofVideo);
}

class VideoDetailBlocProvider extends StatelessWidget implements VideoDetailWidgetParams {
  /// VideoDetailWidgetParams
  @override
  final VideoDetailBloc? videoDetailBloc;
  @override
  final VideoViewModel? ofVideo;
  @override
  final String? ofVideoId;

  /// Widget params
  final Widget child;

  const VideoDetailBlocProvider({
    super.key,

    /// VideoDetailWidgetParams
    this.videoDetailBloc,
    this.ofVideo,
    this.ofVideoId,

    /// Widget params
    required this.child,
  }) : assert(videoDetailBloc == null || ofVideo == null || ofVideoId == null);

  @override
  Widget build(BuildContext context) {
    if (videoDetailBloc != null) {
      return BlocProvider<VideoDetailBloc>.value(
        value: videoDetailBloc!,
        child: child,
      );
    } else {
      return BlocProvider<VideoDetailBloc>(
        create: (context) {
          final videoDetailBloc = VideoDetailBloc(
            videoRepository: Provider.of<VideoRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (ofVideo != null) {
            videoDetailBloc.add((VideoDetailLazyLoad(video: ofVideo!)));
          } else if (ofVideoId != null) {
            videoDetailBloc.add((VideoDetailLoad(videoId: ofVideoId!)));
          }

          return videoDetailBloc;
        },
        child: child,
      );
    }
  }
}

class VideoListTile extends StatelessWidget implements VideoDetailWidgetParams {
  /// VideoDetailWidgetParams
  @override
  final VideoDetailBloc? videoDetailBloc;
  @override
  final VideoViewModel? ofVideo;
  @override
  final String? ofVideoId;

  /// ListTile parameters
  final ItemCallback<VideoViewModel>? onTap;
  final ItemCallback<VideoViewModel>? onLongPress;
  final bool selected;

  const VideoListTile({
    super.key,

    /// VideoDetailWidgetParams
    this.videoDetailBloc,
    this.ofVideo,
    this.ofVideoId,

    /// ListTile parameters
    this.onTap,
    this.onLongPress,
    this.selected = false,
  }) : assert(videoDetailBloc == null || ofVideo == null || ofVideoId == null);

  @override
  Widget build(BuildContext context) {
    return VideoDetailBlocProvider(
      videoDetailBloc: videoDetailBloc,
      ofVideo: ofVideo,
      ofVideoId: ofVideoId,
      child: BlocBuilder<VideoDetailBloc, VideoDetailState>(
        builder: (BuildContext context, VideoDetailState state) {
          return ListTile(
            title: Text(
              '${state.video?.name}',
              overflow: TextOverflow.ellipsis,
            ),
            leading: Hero(
              tag: 'img-video-${state.video?.id ?? state.ofVideoId}',
              transitionOnUserGestures: false,
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    AppStyles.videoThumbnailRadius,
                  ),
                  child: (isYoutube(state.video?.url))
                      ? Image.network(
                          getYoutubeThumbnail(getYoutubeId(state.video!.url) ?? ''),
                          fit: BoxFit.cover,
                        )
                      : Container(),
                ),
              ),
            ),
            subtitle: Text(
              '${state.video?.url}',
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              AutoRouter.of(context).push(
                VideoDetailsRoute(
                  videoDetailBloc: BlocProvider.of<VideoDetailBloc>(context),
                ),
              );
            },
            onLongPress: (onLongPress != null)
                ? () {
                    onLongPress!(state.video!);
                  }
                : null,
            selected: selected,
          );
        },
      ),
    );
  }
}

class CheckboxVideoListTile extends StatelessWidget implements VideoDetailWidgetParams {
  /// VideoDetailWidgetParams
  @override
  final VideoDetailBloc? videoDetailBloc;
  @override
  final VideoViewModel? ofVideo;
  @override
  final String? ofVideoId;

  /// CheckboxLitTile parameters
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxVideoListTile({
    super.key,

    /// VideoDetailWidgetParams
    this.videoDetailBloc,
    this.ofVideo,
    this.ofVideoId,

    /// CheckboxLitTile parameters
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return VideoDetailBlocProvider(
      videoDetailBloc: videoDetailBloc,
      ofVideo: ofVideo,
      ofVideoId: ofVideoId,
      child: BlocBuilder<VideoDetailBloc, VideoDetailState>(
        builder: (BuildContext context, VideoDetailState state) {
          return CheckboxListTile(
            title: (state.video != null) ? Text('${state.video?.name}') : const Text('Loading ...'),
            subtitle: (state.video != null) ? Text('${state.video?.url}') : const Text('Loading ...'),
            value: value,
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}

class VideoCard extends StatelessWidget implements VideoDetailWidgetParams {
  /// VideoDetailWidgetParams
  @override
  final VideoDetailBloc? videoDetailBloc;
  @override
  final VideoViewModel? ofVideo;
  @override
  final String? ofVideoId;

  const VideoCard({
    super.key,

    /// VideoDetailWidgetParams
    this.videoDetailBloc,
    this.ofVideo,
    this.ofVideoId,
  });

  @override
  Widget build(BuildContext context) {
    return VideoDetailBlocProvider(
      videoDetailBloc: videoDetailBloc,
      ofVideo: ofVideo,
      ofVideoId: ofVideoId,
      child: BlocBuilder<VideoDetailBloc, VideoDetailState>(
        builder: (BuildContext context, VideoDetailState state) {
          onTap() => AutoRouter.of(context).push(
                VideoDetailsRoute(
                  videoDetailBloc: BlocProvider.of<VideoDetailBloc>(context),
                ),
              );
          return Padding(
            padding: const EdgeInsets.all(AppStyles.itemPadding),
            child: AspectRatio(
              aspectRatio: AppStyles.artistCardRatio,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Hero(
                      tag: 'img-video-${state.video?.id ?? state.ofVideoId}',
                      transitionOnUserGestures: false,
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppStyles.videoThumbnailRadius,
                          ),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(
                            AppStyles.videoThumbnailRadius,
                          ),
                          onTap: onTap,
                          child: (state.video != null && isYoutube(state.video?.url))
                              ? Image.network(
                            getYoutubeThumbnail(getYoutubeId(state.video!.url) ?? ''),
                                  fit: BoxFit.cover,
                                )
                              : const SizedBox(),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Column(
                      children: [
                        const SizedBox(height: 5),
                        (state.video != null)
                            ? Text(
                                '${state.video?.name}',
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                              )
                            : const Text('Loading ...')
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
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

class VideoThumbnail extends StatelessWidget {
  final String? url;

  const VideoThumbnail({
    Key? key,
    this.url,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url != null) {
      return isYoutube(url!)
          ? Image.network(
        getYoutubeThumbnail(getYoutubeId(url!) ?? ''),
              fit: BoxFit.cover,
            )
          : Container();
    }
    return Container();
  }
}
