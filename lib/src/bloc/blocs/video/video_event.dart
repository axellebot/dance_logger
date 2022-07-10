import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [VideoEvent] that must be dispatch to [VideoBloc]
abstract class VideoEvent extends Equatable {
  const VideoEvent() : super();

  @override
  String toString() => 'VideoEvent{}';
}

class VideoLoad extends VideoEvent {
  final String videoId;

  const VideoLoad({required this.videoId}) : super();

  @override
  String toString() => 'VideoLoad{'
      'videoId: $videoId'
      '}';

  @override
  List<Object?> get props => [videoId];
}
