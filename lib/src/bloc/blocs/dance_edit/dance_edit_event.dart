import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [DanceEditEvent] that must be dispatch to [DanceEditBloc]
abstract class DanceEditEvent extends Equatable {
  const DanceEditEvent() : super();

  @override
  String toString() => 'DanceEditEvent{}';
}

class DanceEditStart extends DanceEditEvent {
  final String? danceId;

  const DanceEditStart({this.danceId}) : super();

  @override
  String toString() {
    return 'DanceEditStart{'
        'danceId: $danceId'
        '}';
  }

  @override
  List<Object?> get props => [danceId];
}

class DanceEditValidation extends DanceEditEvent {
  final DanceViewModel dance;

  const DanceEditValidation({required this.dance}) : super();

  @override
  String toString() {
    return 'DanceEditValidation{'
        'dance: $dance'
        '}';
  }

  @override
  List<Object?> get props => [dance];
}
