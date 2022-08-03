import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [DanceDetailEvent] that must be dispatch to [DanceDetailBloc]
abstract class DanceDetailEvent extends Equatable {
  const DanceDetailEvent() : super();

  @override
  String toString() => 'DanceDetailEvent{}';
}

class DanceDetailLoad extends DanceDetailEvent {
  final String danceId;

  const DanceDetailLoad({required this.danceId}) : super();

  @override
  String toString() {
    return 'DanceDetailLoad{'
        'danceId: $danceId'
        '}';
  }

  @override
  List<Object?> get props => [danceId];
}
