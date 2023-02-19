import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum VideoDetailStatus {
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

class VideoDetailState extends Equatable {
  final VideoDetailStatus status;
  final String? ofVideoId;
  final VideoViewModel? video;
  final Error? error;

  const VideoDetailState({
    this.status = VideoDetailStatus.initial,
    this.ofVideoId,
    this.video,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofVideoId,
        video,
        error,
      ];

  VideoDetailState copyWith({
    VideoDetailStatus? status,
    Optional<String>? ofVideoId,
    Optional<VideoViewModel>? video,
    Optional<Error>? error,
  }) {
    return VideoDetailState(
      status: status ?? this.status,
      ofVideoId: ofVideoId != null ? ofVideoId.orNull : this.ofVideoId,
      video: video != null ? video.orNull : this.video,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'VideoDetailState{'
      'status: $status, '
      'ofVideoId: $ofVideoId, '
      'video: $video, '
      'error: $error'
      '}';
}
