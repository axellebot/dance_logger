import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum VideoRemoteStatus {
  initial,
}

class VideoRemoteState extends Equatable {
  final VideoRemoteStatus status;
  final bool? remoteOpened;
  final Error? error;

  const VideoRemoteState({
    this.status = VideoRemoteStatus.initial,
    this.remoteOpened,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        remoteOpened,
        error,
      ];

  VideoRemoteState copyWith({
    VideoRemoteStatus? status,
    Optional<bool>? remoteOpened,
    Optional<Error>? error,
  }) {
    return VideoRemoteState(
      status: status ?? this.status,
      remoteOpened: remoteOpened != null ? remoteOpened.orNull : this.remoteOpened,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'VideoRemoteState{'
      'status: $status, '
      'remoteOpened: $remoteOpened, '
      'error: $error'
      '}';
}
