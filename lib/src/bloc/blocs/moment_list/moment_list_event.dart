import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
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
  final MomentViewModel moment;

  const MomentListSelect({
    required this.moment,
  });

  @override
  List<Object?> get props => [moment];

  @override
  String toString() => 'MomentListSelect{'
      'moment: $moment'
      '}';
}

class MomentListUnselect extends MomentListEvent {
  final MomentViewModel? moment;

  const MomentListUnselect({
    this.moment,
  });

  @override
  List<Object?> get props => [moment];

  @override
  String toString() => 'MomentListUnselect{'
      'moment: $moment'
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
