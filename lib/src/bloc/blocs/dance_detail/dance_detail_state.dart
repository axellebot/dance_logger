import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum DanceDetailStatus {
  initial,
  loading,
  detailSuccess,
  deleteSuccess,
  failure
}

class DanceDetailState extends Equatable {
  final DanceDetailStatus status;
  final DanceViewModel? dance;
  final Error? error;

  const DanceDetailState({
    this.status = DanceDetailStatus.initial,
    this.dance,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [status, dance, error];

  DanceDetailState copyWith({
    DanceDetailStatus? status,
    DanceViewModel? dance,
    Error? error,
  }) {
    return DanceDetailState(
      status: status ?? this.status,
      dance: dance ?? this.dance,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'DanceDetailLoaded{'
        'status: $status, '
        'dance: $dance, '
        'error: $error'
        '}';
  }
}
