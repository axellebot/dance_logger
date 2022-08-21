import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

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
  final VideoViewModel? initialVideo;
  final String? videoName;
  final String? videoUrl;
  final Error? error;

  const VideoEditState({
    this.status = VideoEditStatus.initial,
    this.initialVideo,
    this.videoName,
    this.videoUrl,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        initialVideo,
        videoName,
        videoUrl,
        error,
      ];

  VideoEditState copyWith({
    VideoEditStatus? status,
    VideoViewModel? initialVideo,
    String? videoName,
    String? videoUrl,
    Error? error,
  }) {
    return VideoEditState(
      status: status ?? this.status,
      initialVideo: initialVideo ?? this.initialVideo,
      videoName: videoName ?? this.videoName,
      videoUrl: videoUrl ?? this.videoUrl,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'VideoEditLoaded{'
      'status: $status, '
      'initialVideo: $initialVideo, '
      'videoName: $videoName, '
      'videoUrl: $videoUrl, '
      'error: $error'
      '}';
}
