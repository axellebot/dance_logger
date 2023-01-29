import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum VideoEditStatus {
  initial,
  loading,
  ready,
  editSuccess,
  deleteSuccess,
  failure
}

class VideoEditState extends Equatable {
  final VideoEditStatus status;
  final String? ofId;
  final VideoViewModel? initialVideo;
  final String? videoName;
  final String? videoUrl;
  final Error? error;

  const VideoEditState({
    this.status = VideoEditStatus.initial,
    this.ofId,
    this.initialVideo,
    this.videoName,
    this.videoUrl,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofId,
        initialVideo,
        videoName,
        videoUrl,
        error,
      ];

  VideoEditState copyWith({
    VideoEditStatus? status,
    Optional<String>? ofId,
    Optional<VideoViewModel>? initialVideo,
    Optional<String>? videoName,
    Optional<String>? videoUrl,
    Optional<bool>? remoteOpened,
    Optional<Error>? error,
  }) {
    return VideoEditState(
      status: status ?? this.status,
      ofId: ofId != null ? ofId.orNull : this.ofId,
      initialVideo:
          initialVideo != null ? initialVideo.orNull : this.initialVideo,
      videoName: videoName != null ? videoName.orNull : this.videoName,
      videoUrl: videoUrl != null ? videoUrl.orNull : this.videoUrl,

      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'VideoEditLoaded{'
      'status: $status, '
      'ofId: $ofId, '
      'initialVideo: $initialVideo, '
      'videoName: $videoName, '
      'videoUrl: $videoUrl, '
      'error: $error'
      '}';
}
