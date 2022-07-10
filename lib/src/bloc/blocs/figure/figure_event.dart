import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [FigureEvent] that must be dispatch to [FigureBloc]
abstract class FigureEvent extends Equatable {
  const FigureEvent() : super();

  @override
  String toString() => 'FigureEvent{}';
}

class FigureLoad extends FigureEvent {
  final String figureId;

  const FigureLoad({required this.figureId}) : super();

  @override
  String toString() => 'FigureLoad{'
      'figureId: $figureId'
      '}';

  @override
  List<Object?> get props => [figureId];
}
