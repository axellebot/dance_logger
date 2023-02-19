import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [VideoRemoteEvent] that must be dispatch to [VideoRemoteBloc]
abstract class VideoRemoteEvent extends Equatable {
  const VideoRemoteEvent() : super();

  @override
  String toString() => 'VideoRemoteEvent{}';
}

class VideoRemoteToggleRemote extends VideoRemoteEvent {
  final bool opened;

  const VideoRemoteToggleRemote({required this.opened}) : super();

  @override
  String toString() => 'VideoRemoteToggleRemote{ '
      'opened: $opened'
      '}';

  @override
  List<Object?> get props => [];
}
