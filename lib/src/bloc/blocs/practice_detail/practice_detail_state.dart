import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum PracticeDetailStatus {
  initial,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class PracticeDetailState extends Equatable {
  final PracticeDetailStatus status;

  final String? ofId;
  final PracticeViewModel? practice;
  final Error? error;

  const PracticeDetailState({
    this.status = PracticeDetailStatus.initial,
    this.ofId,
    this.practice,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [status, ofId, practice, error];

  PracticeDetailState copyWith({
    PracticeDetailStatus? status,
    String? ofId,
    PracticeViewModel? practice,
    Error? error,
  }) {
    return PracticeDetailState(
      status: status ?? this.status,
      ofId: ofId ?? this.ofId,
      practice: practice ?? this.practice,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'PracticeDetailLoaded{'
      'status: $status, '
      'ofId: $ofId, '
      'practice: $practice, '
      'error: $error'
      '}';
}
