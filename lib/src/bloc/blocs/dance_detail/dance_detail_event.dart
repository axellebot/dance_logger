import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [DanceDetailEvent] that must be dispatch to [DanceDetailBloc]
abstract class DanceDetailEvent extends Equatable {
  const DanceDetailEvent() : super();

  @override
  String toString() => 'DanceDetailEvent{}';
}

class DanceDetailLazyLoad extends DanceDetailEvent {
  final DanceViewModel dance;

  const DanceDetailLazyLoad({
    required this.dance,
  }) : super();

  @override
  String toString() => 'DanceDetailLoad{'
      'dance: $dance'
      '}';

  @override
  List<Object?> get props => [dance];
}

class DanceDetailLoad extends DanceDetailEvent {
  final String danceId;

  const DanceDetailLoad({
    required this.danceId,
  }) : super();

  @override
  String toString() => 'DanceDetailLoad{'
      'danceId: $danceId'
      '}';

  @override
  List<Object?> get props => [danceId];
}

class DanceDetailRefresh extends DanceDetailEvent {
  const DanceDetailRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceDetailRefresh{}';
}

class DanceDetailDelete extends DanceDetailEvent {
  const DanceDetailDelete() : super();

  @override
  String toString() => 'DanceDetailDeleted{}';

  @override
  List<Object?> get props => [];
}
