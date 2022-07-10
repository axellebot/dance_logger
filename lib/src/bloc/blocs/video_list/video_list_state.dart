import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:dance/src/bloc/blocs/video_list/video_list_params.dart';
import 'package:equatable/equatable.dart';

abstract class VideoListState extends Equatable {
  const VideoListState();

  @override
  String toString() => 'VideoListState{}';
}

class VideoListUninitialized extends VideoListState {
  const VideoListUninitialized();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'VideoListUninitialized{}';
}

class VideoListRefreshing extends VideoListState {
  const VideoListRefreshing();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'VideoListRefreshing{}';
}

class VideoListLoaded extends VideoListState implements VideoListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  final List<VideoViewModel> videos;
  final bool hasReachedMax;

  const VideoListLoaded({
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    required this.videos,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props =>
      [ofArtist, ofDance, ofFigure, videos, hasReachedMax];

  VideoListLoaded copyWith({
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    List<VideoViewModel>? videos,
    bool? hasReachedMax,
  }) {
    return VideoListLoaded(
      ofArtist: ofArtist ?? this.ofArtist,
      ofDance: ofDance ?? this.ofDance,
      ofFigure: ofFigure ?? this.ofFigure,
      videos: videos ?? this.videos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'VideoListLoaded{'
        'ofArtist: $ofArtist, '
        'ofDance: $ofDance, '
        'ofFigure: $ofFigure, '
        'videos: $videos, '
        'hasReachedMax: $hasReachedMax'
        '}';
  }
}

class VideoListFailed extends VideoListState {
  final Error error;

  const VideoListFailed({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'VideoListFailed{'
      'error: $error'
      '}';
}
