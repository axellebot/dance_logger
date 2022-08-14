import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [DanceDetailEvent] that must be dispatch to [DanceDetailBloc]
abstract class DanceDetailEvent extends Equatable {
  const DanceDetailEvent() : super();

  @override
  String toString() => 'DanceDetailEvent{}';
}

class DanceDetailLoaded extends DanceDetailEvent {
  final String danceId;

  const DanceDetailLoaded({required this.danceId}) : super();

  @override
  String toString() {
    return 'DanceDetailLoad{'
        'danceId: $danceId'
        '}';
  }

  @override
  List<Object?> get props => [danceId];
}

class DanceDetailDeleted extends DanceDetailEvent {
  const DanceDetailDeleted() : super();

  @override
  String toString() {
    return 'DanceDetailDeleted{'
        '}';
  }

  @override
  List<Object?> get props => [];
}
