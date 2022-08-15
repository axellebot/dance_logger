import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      ));

      VideoViewModel? videoViewModel;
      if (event.videoId != null) {
        VideoEntity videoEntity = await videoRepository.getById(event.videoId!);
        videoViewModel = mapper.toVideoViewModel(videoEntity);
      }

      emit(state.copyWith(
        status: VideoEditStatus.ready,
        initialVideo: videoViewModel,
      ));
    } on Error catch (error) {
      emit(VideoEditState(
        status: VideoEditStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onVideoEditChangeName(
    VideoEditChangeName event,
    Emitter<VideoEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoEditChangeName');
    emit(state.copyWith(videoName: event.videoName));
  }

  FutureOr<void> _onVideoEditChangeUrl(
    VideoEditChangeUrl event,
    Emitter<VideoEditState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoEditChangeUrl');
    emit(state.copyWith(videoUrl: event.videoUrl));
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
        videoViewModel = state.initialVideo!;
        videoViewModel.change(
          name: state.videoName,
          url: state.videoUrl,
        );
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
        initialVideo: videoViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoEditStatus.failure,
        error: error,
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
        error: error,
      ));
    }
  }
}
