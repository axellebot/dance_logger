import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quiver/core.dart';

class VideoDetailBloc extends Bloc<VideoDetailEvent, VideoDetailState> {
  final VideoRepository videoRepository;
  final ModelMapper mapper;

  VideoDetailBloc({
    required this.videoRepository,
    required this.mapper,
  }) : super(const VideoDetailState()) {
    on<VideoDetailLazyLoad>(_onVideoDetailLazyLoad);
    on<VideoDetailLoad>(_onVideoDetailLoad);
    on<VideoDetailRefresh>(_onVideoDetailRefresh);
    on<VideoDetailDelete>(_onVideoDelete);
  }

  FutureOr<void> _onVideoDetailLazyLoad(
    VideoDetailLazyLoad event,
    Emitter<VideoDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoDetailLazyLoad');

    emit(state.copyWith(
      status: VideoDetailStatus.loadingSuccess,
      ofVideoId: Optional.of(event.video.id),
      video: Optional.of(event.video),
    ));
  }

  FutureOr<void> _onVideoDetailLoad(
    VideoDetailLoad event,
    Emitter<VideoDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoDetailLoad');

    try {
      emit(state.copyWith(
        status: VideoDetailStatus.loading,
        ofVideoId: Optional.of(event.videoId),
      ));

      VideoEntity videoDataModel = await videoRepository.getById(event.videoId);
      VideoViewModel videoViewModel = mapper.toVideoViewModel(videoDataModel);

      emit(state.copyWith(
        status: VideoDetailStatus.loadingSuccess,
        ofVideoId: Optional.of(videoViewModel.id),
        video: Optional.of(videoViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoDetailStatus.loadingFailure,
        ofVideoId: Optional.of(event.videoId),
        error: Optional.of(error),
      ));
    }
  }

  FutureOr<void> _onVideoDetailRefresh(
    VideoDetailRefresh event,
    Emitter<VideoDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoDetailRefresh');
    try {
      emit(state.copyWith(
        status: VideoDetailStatus.refreshing,
      ));

      VideoEntity videoDataModel = await videoRepository.getById(state.ofVideoId!);
      VideoViewModel videoViewModel = mapper.toVideoViewModel(videoDataModel);

      emit(state.copyWith(
        status: VideoDetailStatus.refreshingSuccess,
        ofVideoId: Optional.of(videoViewModel.id),
        video: Optional.of(videoViewModel),
        error: const Optional.absent(),
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoDetailStatus.refreshingFailure,
        error: Optional.fromNullable(error),
      ));
    }
  }

  FutureOr<void> _onVideoDelete(
    VideoDetailDelete event,
    Emitter<VideoDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoDeleted');
    if (state.video == null) return;
    try {
      await videoRepository.deleteById(state.video!.id);

      emit(const VideoDetailState(
        status: VideoDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoDetailStatus.deleteFailure,
        error: Optional.of(error),
      ));
    }
  }
}
