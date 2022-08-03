import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [FigureDetailEvent] that must be dispatch to [FigureDetailBloc]
abstract class FigureDetailEvent extends Equatable {
  const FigureDetailEvent() : super();

  @override
  String toString() => 'FigureDetailEvent{}';
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
