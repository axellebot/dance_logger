import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

import 'moment_list_params.dart';

/// [MomentListEvent] that must be dispatch to [MomentListBloc]
abstract class MomentListEvent extends Equatable {
  const MomentListEvent();

  @override
  String toString() => 'MomentListEvent{}';
}

class MomentListLoad extends MomentListEvent implements MomentListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const MomentListLoad({
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofArtist, ofFigure, ofVideo];

  @override
  String toString() {
    return 'MomentListLoad{'
        'ofDance: $ofArtist, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo'
        '}';
  }
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
