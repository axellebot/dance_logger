import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

abstract class FigureState extends Equatable {
  const FigureState() : super();

  @override
  String toString() => 'FigureState{}';
}

class FigureUninitialized extends FigureState {
  const FigureUninitialized();

  @override
  List<Object?> get props => [];
}

class FigureLoading extends FigureState {
  const FigureLoading() : super();

  @override
  List<Object?> get props => [];
}

class FigureLoaded extends FigureState {
  final FigureViewModel figure;

  const FigureLoaded({
    required this.figure,
  }) : super();

  @override
  List<Object?> get props => [figure];

  @override
  String toString() {
    return 'FigureLoaded{'
        'figure: $figure'
        '}';
  }
}

class FigureFailure extends FigureState {
  final Error error;

  const FigureFailure({required this.error}) : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'FigureFailure{'
      'error: $error'
      '}';
}
