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
  }

  FutureOr<void> _onVideoDetailLoad(event, emit) async {
    if (kDebugMode) print('$runtimeType:_onVideoDetailLoad');
    try {
      emit(state.copyWith(
        status: VideoDetailStatus.loading,
      ));

      VideoEntity videoDataModel = await videoRepository.getById(event.videoId);
      VideoViewModel videoViewModel = mapper.toVideoViewModel(videoDataModel);

      emit(state.copyWith(
        status: VideoDetailStatus.success,
        video: videoViewModel,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoDetailStatus.failure,
        error: error,
      ));
    }
  }
}
