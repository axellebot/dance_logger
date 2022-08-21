import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum VideoDetailStatus {
  initial,
  loading,
  refreshing,
  detailSuccess,
  deleteSuccess,
  failure,
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
  List<Object?> get props => [status, ofId, video, error];

  VideoDetailState copyWith({
    VideoDetailStatus? status,
    String? ofId,
    VideoViewModel? video,
    Error? error,
  }) {
    return VideoDetailState(
      status: status ?? this.status,
      ofId: ofId ?? this.ofId,
      video: video ?? this.video,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'VideoDetailLoaded{'
      'status: $status, '
      'video: $video, '
      'error: $error'
      '}';
}
