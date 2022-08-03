import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

import 'dance_list_params.dart';

abstract class DanceListState extends Equatable {
  const DanceListState();

  @override
  String toString() => 'DanceListState{}';
}

class DanceListUninitialized extends DanceListState {
  const DanceListUninitialized();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceListUninitialized{}';
}

class DanceListRefreshing extends DanceListState {
  const DanceListRefreshing();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceListRefreshing{}';
}

class DanceListLoaded extends DanceListState implements DanceListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<DanceViewModel> dances;
  final bool hasReachedMax;

  const DanceListLoaded({
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
    required this.dances,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [ofArtist, dances, hasReachedMax];

  DanceListLoaded copyWith({
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    List<DanceViewModel>? dances,
    bool? hasReachedMax,
  }) {
    return DanceListLoaded(
      ofArtist: ofArtist ?? this.ofArtist,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      dances: dances ?? this.dances,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'DanceListLoaded{'
        'ofArtist: $ofArtist, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo, '
        'dances: $dances, '
        'hasReachedMax: $hasReachedMax'
        '}';
  }
}

class DanceListFailed extends DanceListState {
  final Error error;

  const DanceListFailed({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'DanceListFailed{'
      'error: $error'
      '}';
}
