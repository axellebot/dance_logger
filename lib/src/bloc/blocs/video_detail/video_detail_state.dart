import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum VideoDetailStatus {
  initial,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class VideoDetailState extends Equatable {
  final VideoDetailStatus status;
  final String? ofId;
  final VideoViewModel? video;
  final Error? error;

  const VideoDetailState({
    this.status = VideoDetailStatus.initial,
    this.ofId,
    this.video,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofId,
        video,
        error,
      ];

  VideoDetailState copyWith({
    VideoDetailStatus? status,
    Optional<String>? ofId,
    Optional<VideoViewModel>? video,
    Optional<Error>? error,
  }) {
    return VideoDetailState(
      status: status ?? this.status,
      ofId: ofId != null ? ofId.orNull : this.ofId,
      video: video != null ? video.orNull : this.video,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'VideoDetailLoaded{'
      'status: $status, '
      'video: $video, '
      'error: $error'
      '}';
}
