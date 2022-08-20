import 'package:dance/domain.dart';
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
  final String? ofArtist;
  @override
  final String? ofVideo;

  const DanceListLoad({
    /// DanceListParams
    this.ofSearch,
    this.ofArtist,
    this.ofVideo,
  }) : assert(ofSearch == null || (ofArtist == null && ofVideo == null));

  @override
  List<Object?> get props => [ofSearch, ofArtist, ofVideo];

  @override
  String toString() {
    return 'DanceListLoad{'
        'ofSearch: $ofSearch, '
        'ofArtist: $ofArtist, '
        'ofVideo: $ofVideo'
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

class DanceListSelect extends DanceListEvent {
  final String danceId;

  const DanceListSelect({
    required this.danceId,
  });

  @override
  List<Object?> get props => [danceId];

  @override
  String toString() => 'DanceListSelect{'
      'danceId: $danceId'
      '}';
}

class DanceListUnselect extends DanceListEvent {
  final String? danceId;

  const DanceListUnselect({
    this.danceId,
  });

  @override
  List<Object?> get props => [danceId];

  @override
  String toString() => 'DanceListUnselect{'
      'danceId: $danceId'
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
