import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum DanceDetailStatus {
  initial,
  loading,
  loadingSuccess,
  loadingFailure,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class DanceDetailState extends Equatable {
  final DanceDetailStatus status;
  final String? ofDanceId;
  final DanceViewModel? dance;
  final Error? error;

  const DanceDetailState({
    this.status = DanceDetailStatus.initial,
    this.ofDanceId,
    this.dance,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofDanceId,
        dance,
        error,
      ];

  DanceDetailState copyWith({
    DanceDetailStatus? status,
    Optional<String>? ofDanceId,
    Optional<DanceViewModel>? dance,
    Optional<Error>? error,
  }) {
    return DanceDetailState(
      status: status ?? this.status,
      ofDanceId: ofDanceId != null ? ofDanceId.orNull : this.ofDanceId,
      dance: dance != null ? dance.orNull : this.dance,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'DanceDetailLoaded{'
      'status: $status, '
      'ofDanceId: $ofDanceId, '
      'dance: $dance, '
      'error: $error'
      '}';
}
