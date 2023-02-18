import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum PracticeDetailStatus {
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

class PracticeDetailState extends Equatable {
  final PracticeDetailStatus status;
  final String? ofPracticeId;
  final PracticeViewModel? practice;
  final Error? error;

  const PracticeDetailState({
    this.status = PracticeDetailStatus.initial,
    this.ofPracticeId,
    this.practice,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofPracticeId,
        practice,
        error,
      ];

  PracticeDetailState copyWith({
    PracticeDetailStatus? status,
    Optional<String>? ofPracticeId,
    Optional<PracticeViewModel>? practice,
    Optional<Error>? error,
  }) {
    return PracticeDetailState(
      status: status ?? this.status,
      ofPracticeId: ofPracticeId != null ? ofPracticeId.orNull : this.ofPracticeId,
      practice: practice != null ? practice.orNull : this.practice,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'PracticeDetailLoaded{'
      'status: $status, '
      'ofPracticeId: $ofPracticeId, '
      'practice: $practice, '
      'error: $error'
      '}';
}
