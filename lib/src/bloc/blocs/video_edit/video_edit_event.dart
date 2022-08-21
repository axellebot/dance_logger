import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [VideoEditEvent] that must be dispatch to [VideoEditBloc]
abstract class VideoEditEvent extends Equatable {
  const VideoEditEvent() : super();

  @override
  String toString() => 'VideoEditEvent{}';
}

class VideoEditStart extends VideoEditEvent {
  final String? videoId;

  const VideoEditStart({
    this.videoId,
  }) : super();

  @override
  String toString() => 'VideoEditStart{'
      'danceId: $videoId'
      '}';

  @override
  List<Object?> get props => [videoId];
}

class VideoEditChangeName extends VideoEditEvent {
  final String videoName;

  const VideoEditChangeName({required this.videoName}) : super();

  @override
  String toString() => 'VideoEditChangeName{'
      'videoName: $videoName'
      '}';

  @override
  List<Object?> get props => [videoName];
}

class VideoEditChangeUrl extends VideoEditEvent {
  final String videoUrl;

  const VideoEditChangeUrl({required this.videoUrl}) : super();

  @override
  String toString() => 'VideoEditChangeName{'
      'videoUrl: $videoUrl'
      '}';

  @override
  List<Object?> get props => [videoUrl];
}

class VideoEditSubmit extends VideoEditEvent {
  const VideoEditSubmit() : super();

  @override
  String toString() => 'VideoEditSubmit{}';

  @override
  List<Object?> get props => [];
}

class VideoEditDelete extends VideoEditEvent {
  const VideoEditDelete() : super();

  @override
  String toString() => 'VideoEditDelete{}';

  @override
  List<Object?> get props => [];
}
