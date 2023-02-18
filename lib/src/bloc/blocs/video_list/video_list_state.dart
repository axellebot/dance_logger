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
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofFigureId;

  final List<VideoViewModel> videos;
  final bool hasReachedMax;
  final List<VideoViewModel> selectedVideos;
  final Error? error;

  const VideoListState({
    this.status = VideoListStatus.initial,
    this.ofSearch,
    this.ofArtistId,
    this.ofDanceId,
    this.ofFigureId,
    this.videos = const <VideoViewModel>[],
    this.hasReachedMax = false,
    this.selectedVideos = const <VideoViewModel>[],
    this.error,
  }) : assert(ofSearch == null ||
            (ofArtistId == null && ofDanceId == null && ofFigureId == null));

  @override
  List<Object?> get props => [
        status,
        ofSearch,
        ofArtistId,
        ofDanceId,
        ofFigureId,
        videos,
        hasReachedMax,
        selectedVideos,
        error,
      ];

  VideoListState copyWith({
    VideoListStatus? status,
    Optional<String>? ofSearch,
    Optional<String>? ofArtistId,
    Optional<String>? ofDanceId,
    Optional<String>? ofFigureId,
    List<VideoViewModel>? videos,
    bool? hasReachedMax,
    List<VideoViewModel>? selectedVideos,
    Optional<Error>? error,
  }) {
    return VideoListState(
      status: status ?? this.status,
      ofSearch: ofSearch != null ? ofSearch.orNull : this.ofSearch,
      ofArtistId: ofArtistId != null ? ofArtistId.orNull : this.ofArtistId,
      ofDanceId: ofDanceId != null ? ofDanceId.orNull : this.ofDanceId,
      ofFigureId: ofFigureId != null ? ofFigureId.orNull : this.ofFigureId,
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
      'ofArtistId: $ofArtistId, '
      'ofDanceId: $ofDanceId, '
      'ofFigureId: $ofFigureId, '
      'videos: $videos, '
      'hasReachedMax: $hasReachedMax, '
      'selectedVideos: $selectedVideos, '
      'error: $error'
      '}';
}
