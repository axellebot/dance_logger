import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

import 'time_list_params.dart';

/// [TimeListEvent] that must be dispatch to [TimeListBloc]
abstract class TimeListEvent extends Equatable {
  const TimeListEvent();

  @override
  String toString() => 'TimeListEvent{}';
}

class TimeListLoad extends TimeListEvent implements TimeListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const TimeListLoad({
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofArtist, ofFigure, ofVideo];

  @override
  String toString() {
    return 'TimeListLoad{'
        'ofDance: $ofArtist, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo'
        '}';
  }
}

class TimeListLoadMore extends TimeListEvent {
  const TimeListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'TimeListLoadMore{}';
}

class TimeListRefresh extends TimeListEvent {
  const TimeListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'TimeListRefresh{}';
}
