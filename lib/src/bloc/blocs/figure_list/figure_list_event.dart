import 'package:dance/domain.dart';
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
  final String figureId;

  const FigureListSelect({
    required this.figureId,
  });

  @override
  List<Object?> get props => [figureId];

  @override
  String toString() => 'FigureListSelect{'
      'figureId: $figureId'
      '}';
}

class FigureListUnselect extends FigureListEvent {
  final String? figureId;

  const FigureListUnselect({
    this.figureId,
  });

  @override
  List<Object?> get props => [figureId];

  @override
  String toString() => 'FigureListUnselect{'
      'figureId: $figureId'
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
