import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [DanceListEvent] that must be dispatch to [DanceListBloc]
abstract class DanceListEvent extends Equatable {
  const DanceListEvent();

  @override
  String toString() => 'DanceListEvent{}';
}

class DanceListLoad extends DanceListEvent implements DanceListParams {
  /// DanceListParams
  @override
  final String? ofSearch;
  @override
  final String? ofArtistId;
  @override
  final String? ofVideoId;

  const DanceListLoad({
    /// DanceListParams
    this.ofSearch,
    this.ofArtistId,
    this.ofVideoId,
  }) : assert(ofSearch == null || (ofArtistId == null && ofVideoId == null));

  @override
  List<Object?> get props => [ofSearch, ofArtistId, ofVideoId];

  @override
  String toString() => 'DanceListLoad{'
      'ofSearch: $ofSearch, '
      'ofArtist: $ofArtistId, '
      'ofVideo: $ofVideoId'
      '}';
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

class DanceListSelect extends DanceListEvent {
  final List<DanceViewModel> dances;

  const DanceListSelect({
    required this.dances,
  });

  @override
  List<Object?> get props => [dances];

  @override
  String toString() => 'DanceListSelect{'
      'dances: $dances'
      '}';
}

class DanceListUnselect extends DanceListEvent {
  final List<DanceViewModel>? dances;

  const DanceListUnselect({
    this.dances,
  });

  @override
  List<Object?> get props => [dances];

  @override
  String toString() => 'DanceListUnselect{'
      'dances: $dances'
      '}';
}

class DanceListDelete extends DanceListEvent {
  const DanceListDelete();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'DanceListDelete{'
      '}';
}
