import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

import 'dance_list_params.dart';

/// [DanceListEvent] that must be dispatch to [DanceListBloc]
abstract class DanceListEvent extends Equatable {
  const DanceListEvent();

  @override
  String toString() => 'DanceListEvent{}';
}

class DanceListLoad extends DanceListEvent implements DanceListParams {
  @override
  final String? ofArtist;

  const DanceListLoad({
    this.ofArtist,
  });

  @override
  List<Object?> get props => [ofArtist];

  @override
  String toString() {
    return 'DanceListLoadMore{'
        'ofArtist: $ofArtist'
        '}';
  }
}

class DanceListLoadMore extends DanceListEvent {
  const DanceListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceListLoadMore{}';
}

class DanceListRefresh extends DanceListEvent {
  const DanceListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceListRefresh{}';
}
