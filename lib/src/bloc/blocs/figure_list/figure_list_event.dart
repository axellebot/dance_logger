import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

import 'figure_list_params.dart';

/// [FigureListEvent] that must be dispatch to [FigureListBloc]
abstract class FigureListEvent extends Equatable {
  const FigureListEvent();

  @override
  String toString() => 'FigureListEvent{}';
}

class FigureListLoad extends FigureListEvent implements FigureListParams {
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  const FigureListLoad({
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofArtist, ofDance, ofVideo];

  @override
  String toString() {
    return 'FigureListLoadMore{'
        'ofArtist: $ofArtist, '
        'ofDance: $ofDance, '
        'ofVideo: $ofVideo'
        '}';
  }
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
