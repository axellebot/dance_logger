import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum FigureDetailStatus {
  initial,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class FigureDetailState extends Equatable {
  final FigureDetailStatus status;
  final String? ofId;
  final FigureViewModel? figure;
  final Error? error;

  const FigureDetailState({
    this.status = FigureDetailStatus.initial,
    this.ofId,
    this.figure,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofId,
        figure,
        error,
      ];

  FigureDetailState copyWith({
    FigureDetailStatus? status,
    Optional<String>? ofId,
    Optional<FigureViewModel>? figure,
    Optional<Error>? error,
  }) {
    return FigureDetailState(
      status: status ?? this.status,
      ofId: ofId?.orNull ?? this.ofId,
      figure: figure?.orNull ?? this.figure,
      error: error?.orNull ?? this.error,
    );
  }

  @override
  String toString() => 'FigureDetailLoaded{'
      'status: $status, '
      'ofId: $ofId, '
      'figure: $figure, '
      'error: $error'
      '}';
}
