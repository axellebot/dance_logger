import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

abstract class VideoState extends Equatable {
  const VideoState() : super();

  @override
  String toString() => 'VideoState{}';
}

class VideoUninitialized extends VideoState {
  const VideoUninitialized();

  @override
  List<Object?> get props => [];
}

class VideoLoading extends VideoState {
  const VideoLoading() : super();

  @override
  List<Object?> get props => [];
}

class VideoLoaded extends VideoState {
  final VideoViewModel video;

  const VideoLoaded({
    required this.video,
  }) : super();

  @override
  List<Object?> get props => [video];

  @override
  String toString() {
    return 'VideoLoaded{'
        'video: $video'
        '}';
  }
}

class VideoFailed extends VideoState {
  final Error error;

  const VideoFailed({required this.error}) : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'VideoFailure{'
      'error: $error'
      '}';
}
