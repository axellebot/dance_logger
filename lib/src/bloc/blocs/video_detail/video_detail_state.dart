import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum VideoDetailStatus {
  initial,
  loading,
  detailSuccess,
  deleteSuccess,
  failure,
}

class VideoDetailState extends Equatable {
  final VideoDetailStatus status;
  final VideoViewModel? video;
  final Error? error;

  const VideoDetailState({
    this.status = VideoDetailStatus.initial,
    this.video,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [status, video, error];

  VideoDetailState copyWith({
    VideoDetailStatus? status,
    VideoViewModel? video,
    Error? error,
  }) {
    return VideoDetailState(
      status: status ?? this.status,
      video: video ?? this.video,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'VideoDetailLoaded{'
        'status: $status, '
        'video: $video, '
        'error: $error'
        '}';
  }
}
