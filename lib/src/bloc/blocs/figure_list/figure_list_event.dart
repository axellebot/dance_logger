import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [FigureListEvent] that must be dispatch to [FigureListBloc]
abstract class FigureListEvent extends Equatable {
  const FigureListEvent();

  @override
  String toString() => 'FigureListEvent{}';
}

class FigureListLoad extends FigureListEvent implements FigureListParams {
  /// FigureListParams
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  const FigureListLoad({
    /// FigureListParams
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofArtist, ofDance, ofVideo];

  @override
  String toString() => 'FigureListLoadMore{'
      'ofArtist: $ofArtist, '
      'ofDance: $ofDance, '
      'ofVideo: $ofVideo'
      '}';
}

class FigureListLoadMore extends FigureListEvent {
  const FigureListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'FigureListLoadMore{}';
}

class FigureListRefresh extends FigureListEvent {
  const FigureListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'FigureListRefresh{}';
}

class FigureListSelect extends FigureListEvent {
  final FigureViewModel figure;

  const FigureListSelect({
    required this.figure,
  });

  @override
  List<Object?> get props => [figure];

  @override
  String toString() => 'FigureListSelect{'
      'figure: $figure'
      '}';
}

class FigureListUnselect extends FigureListEvent {
  final FigureViewModel? figure;

  const FigureListUnselect({
    this.figure,
  });

  @override
  List<Object?> get props => [figure];

  @override
  String toString() => 'FigureListUnselect{'
      'figure: $figure'
      '}';
}

class FigureListDelete extends FigureListEvent {
  const FigureListDelete();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'FigureListDelete{'
      '}';
}
