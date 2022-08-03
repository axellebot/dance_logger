import 'package:dance/presentation.dart';
import 'package:dance/src/bloc/blocs/time_list/time_list_params.dart';
import 'package:equatable/equatable.dart';

abstract class TimeListState extends Equatable {
  const TimeListState();

  @override
  String toString() => 'TimeListState{}';
}

class TimeListUninitialized extends TimeListState {
  const TimeListUninitialized();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'TimeListUninitialized{}';
}

class TimeListRefreshing extends TimeListState {
  const TimeListRefreshing();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'TimeListRefreshing{}';
}

class TimeListLoaded extends TimeListState implements TimeListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<TimeViewModel> times;
  final bool hasReachedMax;

  const TimeListLoaded({
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
    required this.times,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props =>
      [ofArtist, ofFigure, ofVideo, times, hasReachedMax];

  TimeListLoaded copyWith({
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    List<TimeViewModel>? times,
    bool? hasReachedMax,
  }) {
    return TimeListLoaded(
      ofArtist: ofArtist ?? this.ofArtist,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      times: times ?? this.times,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'TimeListLoaded{'
        'ofDance: $ofArtist, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo, '
        'times: $times, '
        'hasReachedMax: $hasReachedMax'
        '}';
  }
}
