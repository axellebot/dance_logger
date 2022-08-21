import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [VideoDetailEvent] that must be dispatch to [VideoDetailBloc]
abstract class VideoDetailEvent extends Equatable {
  const VideoDetailEvent() : super();

  @override
  String toString() => 'VideoDetailEvent{}';
}

class VideoDetailLoad extends VideoDetailEvent {
  final String videoId;

  const VideoDetailLoad({required this.videoId}) : super();

  @override
  String toString() => 'VideoDetailLoad{'
      'videoId: $videoId'
      '}';

  @override
  List<Object?> get props => [videoId];
}

class VideoDetailRefresh extends VideoDetailEvent {
  const VideoDetailRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'VideoDetailRefresh{}';
}

class VideoDetailDelete extends VideoDetailEvent {
  const VideoDetailDelete() : super();

  @override
  String toString() => 'VideoDetailDeleted{}';

  @override
  List<Object?> get props => [];
}
