import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

/// TODO : Force name and url

class VideoEditBloc extends Bloc<VideoEditEvent, VideoEditState> {
  final VideoRepository videoRepository;
  final ModelMapper mapper;

  VideoEditBloc({
    required this.videoRepository,
    required this.mapper,
  }) : super(const VideoEditState()) {
    on<VideoEditStart>(_onVideoEditStart);
    on<VideoEditChangeName>(_onVideoEditChangeName);
    on<VideoEditChangeUrl>(_onVideoEditChangeUrl);
    on<VideoEditSubmit>(_onVideoEditSubmit);
    on<VideoEditDelete>(_onVideoEditDelete);
  }

  FutureOr<void> _onVideoEditStart(
    VideoEditStart event,
    Emitter<VideoEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoEditStart');

    try {
      emit(state.copyWith(
        status: VideoEditStatus.loading,
        ofId: Optional.fromNullable(event.videoId),
      ));

      VideoViewModel? videoViewModel;
      if (event.videoId != null) {
        VideoEntity videoEntity = await videoRepository.getById(event.videoId!);
        videoViewModel = mapper.toVideoViewModel(videoEntity);
      }

      emit(state.copyWith(
        status: VideoEditStatus.ready,
        ofId: Optional.fromNullable(event.videoId),
        initialVideo: Optional.fromNullable(videoViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoEditStatus.failure,
        ofId: Optional.fromNullable(event.videoId),
        error: Optional.fromNullable(error),
      ));
    }
  }

  FutureOr<void> _onVideoEditChangeName(
    VideoEditChangeName event,
    Emitter<VideoEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoEditChangeName');

    emit(state.copyWith(
      videoName: Optional.of(event.videoName),
    ));
  }

  FutureOr<void> _onVideoEditChangeUrl(
    VideoEditChangeUrl event,
    Emitter<VideoEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoEditChangeUrl');

    emit(state.copyWith(
      videoUrl: Optional.of(event.videoUrl),
    ));
  }

  FutureOr<void> _onVideoEditSubmit(
    VideoEditSubmit event,
    Emitter<VideoEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoEditSubmit');

    try {
      emit(state.copyWith(
        status: VideoEditStatus.loading,
      ));
      VideoViewModel videoViewModel;

      if (state.initialVideo != null) {
        videoViewModel = state.initialVideo!.copyWith(
          name: state.videoName,
          url: state.videoUrl,
        );
        videoViewModel.incrementVersion();
      } else {
        videoViewModel = VideoViewModel.createNew(
          name: state.videoName!,
          url: state.videoUrl!,
        );
      }

      VideoEntity videoEntity =
          await videoRepository.save(mapper.toVideoEntity(videoViewModel));
      videoViewModel = mapper.toVideoViewModel(videoEntity);

      emit(VideoEditState(
        status: VideoEditStatus.editSuccess,
        ofId: videoViewModel.id,
        initialVideo: videoViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoEditStatus.failure,
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onVideoEditDelete(
    VideoEditDelete event,
    Emitter<VideoEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoEditDelete');

    if (state.initialVideo == null) return;
    try {
      emit(state.copyWith(
        status: VideoEditStatus.loading,
      ));

      await videoRepository.deleteById(state.initialVideo!.id);

      emit(const VideoEditState(
        status: VideoEditStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoEditStatus.failure,
        error: Optional.of(error),
      ));
    }
  }
}
