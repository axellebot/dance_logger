import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum DanceDetailStatus {
  initial,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class DanceDetailState extends Equatable {
  final DanceDetailStatus status;

  final String? ofId;
  final DanceViewModel? dance;
  final Error? error;

  const DanceDetailState({
    this.status = DanceDetailStatus.initial,
    this.ofId,
    this.dance,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [status, ofId, dance, error];

  DanceDetailState copyWith({
    DanceDetailStatus? status,
    String? ofId,
    DanceViewModel? dance,
    Error? error,
  }) {
    return DanceDetailState(
      status: status ?? this.status,
      ofId: ofId ?? this.ofId,
      dance: dance ?? this.dance,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'DanceDetailLoaded{'
      'status: $status, '
      'ofId: $ofId, '
      'dance: $dance, '
      'error: $error'
      '}';
}
