import 'package:dance/presentation.dart';
import 'package:dance/src/bloc/blocs/figure_list/figure_list_params.dart';
import 'package:equatable/equatable.dart';

abstract class FigureListState extends Equatable {
  const FigureListState();

  @override
  String toString() => 'FigureListState{}';
}

class FigureListUninitialized extends FigureListState {
  const FigureListUninitialized();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'FigureListUninitialized{}';
}

class FigureListRefreshing extends FigureListState {
  const FigureListRefreshing();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'FigureListRefreshing{}';
}

class FigureListLoaded extends FigureListState implements FigureListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  final List<FigureViewModel> figures;
  final bool hasReachedMax;

  const FigureListLoaded({
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
    required this.figures,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props =>
      [ofArtist, ofDance, ofVideo, figures, hasReachedMax];

  FigureListLoaded copyWith({
    String? ofArtist,
    String? ofDance,
    String? ofVideo,
    List<FigureViewModel>? figures,
    bool? hasReachedMax,
  }) {
    return FigureListLoaded(
      ofArtist: ofArtist ?? this.ofArtist,
      ofDance: ofDance ?? this.ofDance,
      ofVideo: ofVideo ?? this.ofVideo,
      figures: figures ?? this.figures,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'FigureListLoaded{'
        'ofArtist: $ofArtist, '
        'ofDance: $ofDance, '
        'ofVideo: $ofVideo, '
        'figures: $figures, '
        'hasReachedMax: $hasReachedMax'
        '}';
  }
}

class FigureListFailed extends FigureListState {
  final Error error;

  const FigureListFailed({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'FigureListFailed{'
      'error: $error'
      '}';
}
