import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [FigureDetailEvent] that must be dispatch to [FigureDetailBloc]
abstract class FigureDetailEvent extends Equatable {
  const FigureDetailEvent() : super();

  @override
  String toString() => 'FigureDetailEvent{}';
}

class FigureDetailLazyLoad extends FigureDetailEvent {
  final FigureViewModel figure;

  const FigureDetailLazyLoad({
    required this.figure,
  }) : super();

  @override
  String toString() => 'FigureDetailLoad{'
      'figure: $figure'
      '}';

  @override
  List<Object?> get props => [figure];
}

class FigureDetailLoad extends FigureDetailEvent {
  final String figureId;

  const FigureDetailLoad({required this.figureId}) : super();

  @override
  String toString() => 'FigureDetailLoad{'
      'figureId: $figureId'
      '}';

  @override
  List<Object?> get props => [figureId];
}

class FigureDetailRefresh extends FigureDetailEvent {
  const FigureDetailRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'FigureDetailRefresh{}';
}

class FigureDetailDelete extends FigureDetailRefresh {
  const FigureDetailDelete() : super();

  @override
  String toString() => 'FigureDetailDelete{}';

  @override
  List<Object?> get props => [];
}
