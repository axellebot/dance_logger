import 'package:dance/presentation.dart';
import 'package:dance/src/bloc/blocs/video_list/video_list_params.dart';
import 'package:equatable/equatable.dart';

enum VideoListStatus { initial, loading, refreshing, success, failure }

class VideoListState extends Equatable implements VideoListParams {
  final VideoListStatus status;

  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  final List<VideoViewModel> videos;
  final bool hasReachedMax;
  final List<String> selectedVideos;
  final Error? error;

  const VideoListState({
    this.status = VideoListStatus.initial,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.videos = const <VideoViewModel>[],
    this.hasReachedMax = false,
    this.selectedVideos = const <String>[],
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        ofArtist,
        ofDance,
        ofFigure,
        videos,
        hasReachedMax,
        selectedVideos,
        error,
      ];

  VideoListState copyWith({
    VideoListStatus? status,
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    List<VideoViewModel>? videos,
    bool? hasReachedMax,
    List<String>? selectedVideos,
    Error? error,
  }) {
    return VideoListState(
      status: status ?? this.status,
      ofArtist: ofArtist ?? this.ofArtist,
      ofDance: ofDance ?? this.ofDance,
      ofFigure: ofFigure ?? this.ofFigure,
      videos: videos ?? this.videos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedVideos: selectedVideos ?? this.selectedVideos,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'VideoListState{'
        'status: $status, '
        'ofArtist: $ofArtist, '
        'ofDance: $ofDance, '
        'ofFigure: $ofFigure, '
        'videos: $videos, '
        'hasReachedMax: $hasReachedMax, '
        'selectedVideos: $selectedVideos, '
        'error: $error'
        '}';
  }
}
