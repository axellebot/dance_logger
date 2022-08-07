import 'package:dance/presentation.dart';
import 'package:dance/src/bloc/blocs/moment_list/moment_list_params.dart';
import 'package:equatable/equatable.dart';

abstract class MomentListState extends Equatable {
  const MomentListState();

  @override
  String toString() => 'MomentListState{}';
}

class MomentListUninitialized extends MomentListState {
  const MomentListUninitialized();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'MomentListUninitialized{}';
}

class MomentListRefreshing extends MomentListState {
  const MomentListRefreshing();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'MomentListRefreshing{}';
}

class MomentListLoaded extends MomentListState implements MomentListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<MomentViewModel> times;
  final bool hasReachedMax;

  const MomentListLoaded({
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
    required this.times,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props =>
      [ofArtist, ofFigure, ofVideo, times, hasReachedMax];

  MomentListLoaded copyWith({
    String? ofArtist,
    String? ofFigure,
    String? ofVideo,
    List<MomentViewModel>? times,
    bool? hasReachedMax,
  }) {
    return MomentListLoaded(
      ofArtist: ofArtist ?? this.ofArtist,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      times: times ?? this.times,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'MomentListLoaded{'
        'ofDance: $ofArtist, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo, '
        'times: $times, '
        'hasReachedMax: $hasReachedMax'
        '}';
  }
}
