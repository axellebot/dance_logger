import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

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
  final String? ofId;
  final DanceViewModel? initialDance;
  final String? danceName;
  final Error? error;

  const DanceEditState({
    this.status = DanceEditStatus.initial,
    this.ofId,
    this.initialDance,
    this.danceName,
    this.error,
  }) : super();

  @override
  List<Object?> get props =>
      [
        status,
        ofId,
        initialDance,
        danceName,
        error,
      ];

  DanceEditState copyWith({
    DanceEditStatus? status,
    Optional<String>? ofId,
    Optional<DanceViewModel>? initialDance,
    Optional<String>? danceName,
    Optional<Error>? error,
  }) {
    return DanceEditState(
      status: status ?? this.status,
      ofId: ofId?.orNull ?? this.ofId,
      initialDance: initialDance?.orNull ?? this.initialDance,
      danceName: danceName?.orNull ?? this.danceName,
      error: error?.orNull ?? this.error,
    );
  }

  @override
  String toString() => 'DanceEditLoaded{'
      'status: $status, '
      'ofId: $ofId, '
      'initialDance: $initialDance, '
      'danceName: $danceName, '
      'error: $error'
      '}';
}
