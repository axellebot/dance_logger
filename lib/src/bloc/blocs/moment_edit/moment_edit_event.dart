import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../presentation.dart';

/// [MomentEditEvent] that must be dispatch to [MomentEditBloc]
abstract class MomentEditEvent extends Equatable {
  const MomentEditEvent() : super();

  @override
  String toString() => 'MomentEditEvent{}';
}

class MomentEditStart extends MomentEditEvent {
  final String? momentId;

  const MomentEditStart({
    this.momentId,
  }) : super();

  @override
  String toString() => 'MomentEditStart{'
      'momentId: $momentId'
      '}';

  @override
  List<Object?> get props => [momentId];
}

class MomentEditChangeStartTime extends MomentEditEvent {
  final Duration startTime;

  const MomentEditChangeStartTime({required this.startTime}) : super();

  @override
  String toString() => 'MomentEditChangeStartTime{'
      'startTime: $startTime'
      '}';

  @override
  List<Object?> get props => [startTime];
}

class MomentEditChangeEndTime extends MomentEditEvent {
  final Duration? endTime;

  const MomentEditChangeEndTime({this.endTime}) : super();

  @override
  String toString() => 'MomentEditChangeEndTime{'
      'endTime: $endTime'
      '}';

  @override
  List<Object?> get props => [endTime];
}

class MomentEditChangeFigure extends MomentEditEvent {
  final FigureViewModel figure;

  const MomentEditChangeFigure({required this.figure}) : super();

  @override
  String toString() => 'MomentEditChangeFigure{'
      'figure: $figure'
      '}';

  @override
  List<Object?> get props => [figure];
}

class MomentEditChangeVideo extends MomentEditEvent {
  final VideoViewModel video;

  const MomentEditChangeVideo({required this.video}) : super();

  @override
  String toString() => 'MomentEditChangeVideo{'
      'video: $video'
      '}';

  @override
  List<Object?> get props => [video];
}

class MomentEditChangeArtists extends MomentEditEvent {
  final List<ArtistViewModel> artists;

  const MomentEditChangeArtists({required this.artists}) : super();

  @override
  String toString() => 'MomentEditChangeArtists{'
      'artists: $artists'
      '}';

  @override
  List<Object?> get props => [artists];
}

class MomentEditSubmit extends MomentEditEvent {
  const MomentEditSubmit() : super();

  @override
  String toString() => 'MomentEditSubmit{}';

  @override
  List<Object?> get props => [];
}

class MomentEditDelete extends MomentEditEvent {
  const MomentEditDelete() : super();

  @override
  String toString() => 'MomentEditDelete{}';

  @override
  List<Object?> get props => [];
}
