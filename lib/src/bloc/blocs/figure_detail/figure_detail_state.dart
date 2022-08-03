import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum FigureDetailStatus { initial, loading, success, failure }

class FigureDetailState extends Equatable {
  final FigureDetailStatus status;
  final FigureViewModel? figure;
  final Error? error;

  const FigureDetailState({
    this.status = FigureDetailStatus.initial,
    this.figure,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [status, figure, error];

  FigureDetailState copyWith({
    FigureDetailStatus? status,
    FigureViewModel? figure,
    Error? error,
  }) {
    return FigureDetailState(
      status: status ?? this.status,
      figure: figure ?? this.figure,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'FigureDetailLoaded{'
        'status: $status, '
        'figure: $figure, '
        'error: $error'
        '}';
  }
}
