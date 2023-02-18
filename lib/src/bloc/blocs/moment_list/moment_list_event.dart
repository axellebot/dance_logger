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
  final String? ofArtistId;
  @override
  final String? ofFigureId;
  @override
  final String? ofVideoId;

  const MomentListLoad({
    /// MomentListParams
    this.ofArtistId,
    this.ofFigureId,
    this.ofVideoId,
  });

  @override
  List<Object?> get props => [ofArtistId, ofFigureId, ofVideoId];

  @override
  String toString() => 'MomentListLoad{'
      'ofArtistId: $ofArtistId, '
      'ofFigure: $ofFigureId, '
      'ofVideo: $ofVideoId'
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
  final List<MomentViewModel> moments;

  const MomentListSelect({
    required this.moments,
  });

  @override
  List<Object?> get props => [moments];

  @override
  String toString() => 'MomentListSelect{'
      'moments: $moments'
      '}';
}

class MomentListUnselect extends MomentListEvent {
  final List<MomentViewModel>? moments;

  const MomentListUnselect({
    this.moments,
  });

  @override
  List<Object?> get props => [moments];

  @override
  String toString() => 'MomentListUnselect{'
      'moments: $moments'
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
