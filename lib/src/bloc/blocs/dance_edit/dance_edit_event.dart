import 'package:dance/bloc.dart';
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

class DanceEditChangeName extends DanceEditEvent {
  final String danceName;

  const DanceEditChangeName({required this.danceName}) : super();

  @override
  String toString() {
    return 'DanceEditChangeName{'
        'danceName: $danceName'
        '}';
  }

  @override
  List<Object?> get props => [danceName];
}

class DanceEditSubmit extends DanceEditEvent {
  const DanceEditSubmit() : super();

  @override
  String toString() {
    return 'DanceEditSubmit{'
        '}';
  }

  @override
  List<Object?> get props => [];
}

class DanceEditDelete extends DanceEditEvent {
  const DanceEditDelete() : super();

  @override
  String toString() {
    return 'DanceEditDelete{'
        '}';
  }

  @override
  List<Object?> get props => [];
}
