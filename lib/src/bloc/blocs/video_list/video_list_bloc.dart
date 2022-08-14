import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  final VideoRepository videoRepository;
  final ModelMapper mapper;

  VideoListBloc({
    required this.videoRepository,
    required this.mapper,
  }) : super(const VideoListState()) {
    on<VideoListLoad>(_onVideoListLoad);
    on<VideoListLoadMore>(_onVideoListLoadMore);
    on<VideoListRefresh>(_onVideoListRefresh);
  }

  FutureOr<void> _onVideoListLoad(
    VideoListLoad event,
    Emitter<VideoListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoListLoad');
    try {
      emit(state.copyWith(
        status: VideoListStatus.loading,
      ));

      final List<VideoViewModel> videoViewModels;
      videoViewModels = await _fetchVideos(
        ofArtist: event.ofArtist,
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        offset: 0,
      );

      emit(state.copyWith(
        status: VideoListStatus.success,
        ofArtist: event.ofArtist,
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        videos: videoViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onVideoListLoadMore(
    VideoListLoadMore event,
    Emitter<VideoListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoListLoadMore');
    if (state.status != VideoListStatus.success) return;
    try {
      List<VideoViewModel> videoViewModels;

      videoViewModels = await _fetchVideos(
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        offset: state.videos.length,
      );
      if (videoViewModels.isNotEmpty) {
        emit(state.copyWith(
          videos: List.of(state.videos)..addAll(videoViewModels),
          hasReachedMax: videoViewModels.isEmpty,
        ));
      } else {
        emit(state.copyWith(
          hasReachedMax: true,
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoListStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onVideoListRefresh(
    VideoListRefresh event,
    Emitter<VideoListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoListRefresh');
    try {
      emit(state.copyWith(
        status: VideoListStatus.loading,
      ));

      List<VideoViewModel> videoViewModels = await _fetchVideos(
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        offset: 0,
      );

      emit(state.copyWith(
        status: VideoListStatus.success,
        videos: videoViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoListStatus.failure,
        error: error,
      ));
    }
  }

  Future<List<VideoViewModel>> _fetchVideos({
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    required int offset,
    int limit = 10,
  }) async {
    if (kDebugMode) print('$runtimeType:_fetchVideos');
    List<VideoEntity> videoEntities;

    if (ofArtist != null) {
      videoEntities = await videoRepository.getVideosOfArtist(
        ofArtist,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofDance != null) {
      videoEntities = await videoRepository.getVideosOfDance(
        ofDance,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofFigure != null) {
      videoEntities = await videoRepository.getVideosOfFigure(
        ofFigure,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else {
      videoEntities = await videoRepository.getList(
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    }

    List<VideoViewModel> videoViewModels = videoEntities
        .map<VideoViewModel>(
            (videoEntity) => mapper.toVideoViewModel(videoEntity))
        .toList();
    return videoViewModels;
  }
}
