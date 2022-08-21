import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum DanceEditStatus {
  initial,
  loading,
  ready,
  editSuccess,
  deleteSuccess,
  failure
}

class DanceEditState extends Equatable {
  final DanceEditStatus status;
  final DanceViewModel? initialDance;
  final String? danceName;
  final Error? error;

  const DanceEditState({
    this.status = DanceEditStatus.initial,
    this.initialDance,
    this.danceName,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        initialDance,
        danceName,
        error,
      ];

  DanceEditState copyWith({
    DanceEditStatus? status,
    DanceViewModel? initialDance,
    String? danceName,
    Error? error,
  }) {
    return DanceEditState(
      status: status ?? this.status,
      initialDance: initialDance ?? this.initialDance,
      danceName: danceName ?? this.danceName,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'DanceEditLoaded{'
      'status: $status, '
      'initialDance: $initialDance, '
      'danceName: $danceName, '
      'error: $error'
      '}';
}
