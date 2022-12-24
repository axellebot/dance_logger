import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

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
  List<Object?> get props => [
        status,
        ofId,
        practice,
        error,
      ];

  PracticeDetailState copyWith({
    PracticeDetailStatus? status,
    Optional<String>? ofId,
    Optional<PracticeViewModel>? practice,
    Optional<Error>? error,
  }) {
    return PracticeDetailState(
      status: status ?? this.status,
      ofId: ofId != null ? ofId.orNull : this.ofId,
      practice: practice != null ? practice.orNull : this.practice,
      error: error != null ? error.orNull : this.error,
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
