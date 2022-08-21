import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoDetailBloc extends Bloc<VideoDetailEvent, VideoDetailState> {
  final VideoRepository videoRepository;
  final ModelMapper mapper;

  VideoDetailBloc({
    required this.videoRepository,
    required this.mapper,
  }) : super(const VideoDetailState()) {
    on<VideoDetailLoad>(_onVideoDetailLoad);
    on<VideoDetailRefresh>(_onVideoDetailRefresh);
    on<VideoDetailDelete>(_onVideoDelete);
  }

  FutureOr<void> _onVideoDetailLoad(
    VideoDetailLoad event,
    Emitter<VideoDetailState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoDetailLoad');
    try {
      emit(state.copyWith(
        status: VideoDetailStatus.loading,
      ));

      VideoEntity videoDataModel = await videoRepository.getById(event.videoId);
      VideoViewModel videoViewModel = mapper.toVideoViewModel(videoDataModel);

      emit(state.copyWith(
        status: VideoDetailStatus.detailSuccess,
        ofId: videoViewModel.id,
        video: videoViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoDetailStatus.failure,
        ofId: event.videoId,
        error: error,
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

      VideoEntity videoDataModel = await videoRepository.getById(state.ofId!);
      VideoViewModel videoViewModel = mapper.toVideoViewModel(videoDataModel);

      emit(state.copyWith(
        status: VideoDetailStatus.detailSuccess,
        ofId: videoViewModel.id,
        video: videoViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoDetailStatus.failure,
        error: error,
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
      emit(state.copyWith(
        status: VideoDetailStatus.loading,
      ));

      await videoRepository.deleteById(state.video!.id);

      emit(const VideoDetailState(
        status: VideoDetailStatus.deleteSuccess,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoDetailStatus.failure,
        error: error,
      ));
    }
  }
}
