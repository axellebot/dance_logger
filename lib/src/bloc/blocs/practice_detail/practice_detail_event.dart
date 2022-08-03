import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [PracticeDetailEvent] that must be dispatch to [PracticeDetailBloc]
abstract class PracticeDetailEvent extends Equatable {
  const PracticeDetailEvent() : super();

  @override
  String toString() => 'PracticeEvent{}';
}

class PracticeDetailLoad extends PracticeDetailEvent {
  final String practiceId;

  const PracticeDetailLoad({required this.practiceId}) : super();

  @override
  String toString() => 'PracticeDetailLoad{'
      'practiceId: $practiceId'
      '}';

  @override
  List<Object?> get props => [practiceId];
}
