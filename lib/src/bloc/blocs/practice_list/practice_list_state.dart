import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'practice_list_params.dart';

abstract class PracticeListState extends Equatable {
  const PracticeListState();

  @override
  String toString() => 'PracticeListState{}';
}

class PracticeListUninitialized extends PracticeListState {
  const PracticeListUninitialized();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListUninitialized{}';
}

class PracticeListRefreshing extends PracticeListState {
  const PracticeListRefreshing();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'PracticeListRefreshing{}';
}

class PracticeListLoaded extends PracticeListState
    implements PracticeListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<PracticeViewModel> practices;
  final bool hasReachedMax;

  const PracticeListLoaded({
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
    required this.practices,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props => [practices, hasReachedMax];

  PracticeListLoaded copyWith({
    String? ofArtist,
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    List<PracticeViewModel>? practices,
    bool? hasReachedMax,
  }) {
    return PracticeListLoaded(
      ofArtist: ofArtist ?? this.ofArtist,
      ofDance: ofDance ?? this.ofDance,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      practices: practices ?? this.practices,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() => 'PracticeListLoaded{'
      'ofArtist: $ofArtist, '
      'ofDance: $ofDance, '
      'ofFigure: $ofFigure, '
      'ofVideo: $ofVideo, '
      'practices: $practices, '
      'hasReachedMax: $hasReachedMax'
      '}';
}

class PracticeListFailed extends PracticeListState {
  final Error error;

  const PracticeListFailed({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'PracticeListFailed{'
      'error: $error'
      '}';
}
