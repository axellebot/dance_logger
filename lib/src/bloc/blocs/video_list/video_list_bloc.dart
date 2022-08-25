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
    on<VideoListSelect>(_onVideoListSelect);
    on<VideoListUnselect>(_onVideoListUnselect);
    on<VideoListDelete>(_onVideoListDelete);
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
        ofSearch: event.ofSearch,
        ofArtist: event.ofArtist,
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        offset: 0,
      );

      emit(state.copyWith(
        status: VideoListStatus.loadingSuccess,
        ofSearch: event.ofSearch,
        ofArtist: event.ofArtist,
        ofDance: event.ofDance,
        ofFigure: event.ofFigure,
        videos: videoViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoListStatus.loadingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onVideoListLoadMore(
    VideoListLoadMore event,
    Emitter<VideoListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoListLoadMore');
    try {
      emit(state.copyWith(
        status: VideoListStatus.loading,
      ));

      final List<VideoViewModel> videoViewModels;
      videoViewModels = await _fetchVideos(
        ofSearch: state.ofSearch,
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        offset: state.videos.length,
      );

      emit(state.copyWith(
        status: VideoListStatus.loadingSuccess,
        videos: List.of(state.videos)..addAll(videoViewModels),
        hasReachedMax: videoViewModels.isEmpty,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoListStatus.loadingFailure,
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
        status: VideoListStatus.refreshing,
      ));

      List<VideoViewModel> videoViewModels = await _fetchVideos(
        ofSearch: state.ofSearch,
        ofArtist: state.ofArtist,
        ofDance: state.ofDance,
        ofFigure: state.ofFigure,
        offset: 0,
      );

      emit(state.copyWith(
        status: VideoListStatus.refreshingSuccess,
        videos: videoViewModels,
        hasReachedMax: false,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoListStatus.refreshingFailure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onVideoListSelect(
    VideoListSelect event,
    Emitter<VideoListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoListSelect');

    emit(state.copyWith(
      selectedVideos: List.of(state.selectedVideos)..add(event.video),
    ));
  }

  FutureOr<void> _onVideoListUnselect(
    VideoListUnselect event,
    Emitter<VideoListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoListUnselect');

    emit((event.video != null)
        ? state.copyWith(
            selectedVideos: List.of(state.selectedVideos)..remove(event.video),
          )
        : state.copyWith(
            selectedVideos: [],
          ));
  }

  FutureOr<void> _onVideoListDelete(
    VideoListDelete event,
    Emitter<VideoListState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onVideoListSelect');
    if (state.selectedVideos.isEmpty) return;

    try {
      for (VideoViewModel video in state.selectedVideos) {
        await videoRepository.deleteById(video.id);
        emit(state.copyWith(
          status: VideoListStatus.deleteSuccess,
          videos: List.of(state.videos)
            ..removeWhere((element) => element == video),
          selectedVideos: List.of(state.selectedVideos)..remove(video),
        ));
      }
    } on Error catch (error) {
      emit(state.copyWith(
        status: VideoListStatus.deleteFailure,
        error: error,
      ));
    }
  }

  Future<List<VideoViewModel>> _fetchVideos({
    String? ofSearch,
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    required int offset,
    int limit = 10,
  }) async {
    assert(ofSearch == null ||
        (ofArtist == null && ofDance == null && ofFigure == null));
    if (kDebugMode) print('$runtimeType:_fetchVideos');
    List<VideoEntity> videoEntities;
    if (ofSearch != null) {
      videoEntities = await videoRepository.getListOfSearch(
        ofSearch,
        offset: Offset(
          offset: offset,
          limit: limit,
        ),
      );
    } else if (ofArtist != null) {
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
