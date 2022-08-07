import 'package:dance/presentation.dart';
import 'package:dance/src/bloc/blocs/video_list/video_list_params.dart';
import 'package:equatable/equatable.dart';

enum VideoListStatus { initial, loading, success, failure }

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
  final Error? error;

  const VideoListState({
    this.status = VideoListStatus.initial,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.videos = const <VideoViewModel>[],
    this.hasReachedMax = false,
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
        error,
      ];

  VideoListState copyWith({
    VideoListStatus? status,
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    List<VideoViewModel>? videos,
    bool? hasReachedMax,
    Error? error,
  }) {
    return VideoListState(
      status: status ?? this.status,
      ofArtist: ofArtist ?? this.ofArtist,
      ofDance: ofDance ?? this.ofDance,
      ofFigure: ofFigure ?? this.ofFigure,
      videos: videos ?? this.videos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
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
        'error: $error'
        '}';
  }
}
