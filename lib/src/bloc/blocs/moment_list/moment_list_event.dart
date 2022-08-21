import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:equatable/equatable.dart';

/// [MomentListEvent] that must be dispatch to [MomentListBloc]
abstract class MomentListEvent extends Equatable {
  const MomentListEvent();

  @override
  String toString() => 'MomentListEvent{}';
}

class MomentListLoad extends MomentListEvent implements MomentListParams {
  /// MomentListParams
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const MomentListLoad({
    /// MomentListParams
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofArtist, ofFigure, ofVideo];

  @override
  String toString() => 'MomentListLoad{'
      'ofDance: $ofArtist, '
      'ofFigure: $ofFigure, '
      'ofVideo: $ofVideo'
      '}';
}

class MomentListLoadMore extends MomentListEvent {
  const MomentListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'MomentListLoadMore{}';
}

class MomentListRefresh extends MomentListEvent {
  const MomentListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'MomentListRefresh{}';
}

class MomentListSelect extends MomentListEvent {
  final String momentId;

  const MomentListSelect({
    required this.momentId,
  });

  @override
  List<Object?> get props => [momentId];

  @override
  String toString() => 'MomentListSelect{'
      'momentId: $momentId'
      '}';
}

class MomentListUnselect extends MomentListEvent {
  final String? momentId;

  const MomentListUnselect({
    this.momentId,
  });

  @override
  List<Object?> get props => [momentId];

  @override
  String toString() => 'MomentListUnselect{'
      'momentId: $momentId'
      '}';
}

class MomentListDelete extends MomentListEvent {
  const MomentListDelete();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'MomentListDelete{'
      '}';
}
