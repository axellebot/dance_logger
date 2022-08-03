import 'dart:async';

import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  final VideoRepository videoRepository;
  final ModelMapper mapper;

  VideoListBloc({
    required this.videoRepository,
    required this.mapper,
  }) : super(const VideoListUninitialized()) {
    on<VideoListLoad>(__onVideoListLoad);
    on<VideoListLoadMore>(_onVideoListLoadMore);
    on<VideoListRefresh>(_onVideoListRefresh);
  }

  FutureOr<void> __onVideoListLoad(event, emit) async {
    final List<VideoViewModel> videoViewModels;
    videoViewModels = await _fetchVideos(
      ofArtist: event.ofArtist,
      ofDance: event.ofDance,
      ofFigure: event.ofFigure,
      offset: 0,
    );
    emit(VideoListLoaded(
      ofArtist: event.ofArtist,
      ofDance: event.ofDance,
      ofFigure: event.ofFigure,
      videos: videoViewModels,
      hasReachedMax: false,
    ));
  }

  FutureOr<void> _onVideoListLoadMore(event, emit) async {
    if (state is VideoListLoaded) {
      List<VideoViewModel> videoViewModels;
      videoViewModels = await _fetchVideos(
        ofArtist: (state as VideoListLoaded).ofArtist,
        ofDance: (state as VideoListLoaded).ofDance,
        ofFigure: (state as VideoListLoaded).ofFigure,
        offset: (state as VideoListLoaded).videos.length,
      );

      if (videoViewModels.isNotEmpty) {
        emit((state as VideoListLoaded).copyWith(
          videos: (state as VideoListLoaded).videos + videoViewModels,
          hasReachedMax: videoViewModels.isEmpty,
        ));
      } else {
        emit((state as VideoListLoaded).copyWith(
          hasReachedMax: true,
        ));
      }
    }
  }

  FutureOr<void> _onVideoListRefresh(event, emit) async {
    if (state is VideoListLoaded) {
      List<VideoViewModel> videoViewModels = await _fetchVideos(
        ofArtist: (state as VideoListLoaded).ofArtist,
        ofDance: (state as VideoListLoaded).ofDance,
        ofFigure: (state as VideoListLoaded).ofFigure,
        offset: 0,
      );

      emit((state as VideoListLoaded).copyWith(
        videos: videoViewModels,
        hasReachedMax: false,
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
