import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum FigureDetailStatus {
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

class FigureDetailState extends Equatable {
  final FigureDetailStatus status;
  final String? ofFigureId;
  final FigureViewModel? figure;
  final Error? error;

  const FigureDetailState({
    this.status = FigureDetailStatus.initial,
    this.ofFigureId,
    this.figure,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofFigureId,
        figure,
        error,
      ];

  FigureDetailState copyWith({
    FigureDetailStatus? status,
    Optional<String>? ofFigureId,
    Optional<FigureViewModel>? figure,
    Optional<Error>? error,
  }) {
    return FigureDetailState(
      status: status ?? this.status,
      ofFigureId: ofFigureId != null ? ofFigureId.orNull : this.ofFigureId,
      figure: figure != null ? figure.orNull : this.figure,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'FigureDetailLoaded{'
      'status: $status, '
      'ofId: $ofFigureId, '
      'figure: $figure, '
      'error: $error'
      '}';
}
