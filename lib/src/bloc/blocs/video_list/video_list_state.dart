import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum VideoListStatus {
  initial,
  loading,
  loadingSuccess,
  loadingFailure,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class VideoListState extends Equatable implements VideoListParams {
  final VideoListStatus status;

  @override
  final String? ofSearch;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;

  final List<VideoViewModel> videos;
  final bool hasReachedMax;
  final List<VideoViewModel> selectedVideos;
  final Error? error;

  const VideoListState({
    this.status = VideoListStatus.initial,
    this.ofSearch,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.videos = const <VideoViewModel>[],
    this.hasReachedMax = false,
    this.selectedVideos = const <VideoViewModel>[],
    this.error,
  }) : assert(ofSearch == null ||
            (ofArtist == null && ofDance == null && ofFigure == null));

  @override
  List<Object?> get props => [
        status,
        ofSearch,
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
    Optional<String>? ofSearch,
    Optional<String>? ofArtist,
    Optional<String>? ofDance,
    Optional<String>? ofFigure,
    List<VideoViewModel>? videos,
    bool? hasReachedMax,
    List<VideoViewModel>? selectedVideos,
    Optional<Error>? error,
  }) {
    return VideoListState(
      status: status ?? this.status,
      ofSearch: ofSearch != null ? ofSearch.orNull : this.ofSearch,
      ofArtist: ofArtist != null ? ofArtist.orNull : this.ofArtist,
      ofDance: ofDance != null ? ofDance.orNull : this.ofDance,
      ofFigure: ofFigure != null ? ofFigure.orNull : this.ofFigure,
      videos: videos ?? this.videos,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedVideos: selectedVideos ?? this.selectedVideos,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'VideoListState{'
      'status: $status, '
      'ofSearch: $ofSearch, '
      'ofArtist: $ofArtist, '
      'ofDance: $ofDance, '
      'ofFigure: $ofFigure, '
      'videos: $videos, '
      'hasReachedMax: $hasReachedMax, '
      'selectedVideos: $selectedVideos, '
      'error: $error'
      '}';
}
