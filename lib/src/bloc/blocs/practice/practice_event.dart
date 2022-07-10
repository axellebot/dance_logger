import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [PracticeEvent] that must be dispatch to [PracticeBloc]
abstract class PracticeEvent extends Equatable {
  const PracticeEvent() : super();

  @override
  String toString() => 'PracticeEvent{}';
}

class PracticeLoad extends PracticeEvent {
  final String practiceId;

  const PracticeLoad({required this.practiceId}) : super();

  @override
  String toString() => 'PracticeLoad{'
      'practiceId: $practiceId'
      '}';

  @override
  List<Object?> get props => [practiceId];
}
