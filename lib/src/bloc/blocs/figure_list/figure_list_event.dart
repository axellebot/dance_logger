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
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofVideoId;

  const FigureListLoad({
    /// FigureListParams
    this.ofArtistId,
    this.ofDanceId,
    this.ofVideoId,
  });

  @override
  List<Object?> get props => [ofArtistId, ofDanceId, ofVideoId];

  @override
  String toString() => 'FigureListLoadMore{'
      'ofArtistId: $ofArtistId, '
      'ofDanceId: $ofDanceId, '
      'ofVideoId: $ofVideoId'
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
  final List<FigureViewModel> figures;

  const FigureListSelect({
    required this.figures,
  });

  @override
  List<Object?> get props => [figures];

  @override
  String toString() => 'FigureListSelect{'
      'figures: $figures'
      '}';
}

class FigureListUnselect extends FigureListEvent {
  final List<FigureViewModel>? figures;

  const FigureListUnselect({
    this.figures,
  });

  @override
  List<Object?> get props => [figures];

  @override
  String toString() => 'FigureListUnselect{'
      'figures: $figures'
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
