import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum PracticeDetailStatus { initial, loading, success, failure }

class PracticeDetailState extends Equatable {
  final PracticeDetailStatus status;
  final PracticeViewModel? practice;
  final Error? error;

  const PracticeDetailState({
    this.status = PracticeDetailStatus.initial,
    this.practice,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [status, practice, error];

  PracticeDetailState copyWith({
    PracticeDetailStatus? status,
    PracticeViewModel? practice,
    Error? error,
  }) {
    return PracticeDetailState(
      status: status ?? this.status,
      practice: practice ?? this.practice,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'PracticeDetailLoaded{'
        'status: $status, '
        'practice: $practice, '
        'error: $error'
        '}';
  }
}
