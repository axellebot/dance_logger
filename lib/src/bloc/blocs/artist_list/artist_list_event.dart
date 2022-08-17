import 'package:dance/domain.dart';
import 'package:equatable/equatable.dart';

/// [ArtistListEvent] that must be dispatch to [ArtistListBloc]
abstract class ArtistListEvent extends Equatable {
  const ArtistListEvent();

  @override
  String toString() => 'ArtistListEvent{}';
}

class ArtistListLoad extends ArtistListEvent implements ArtistListParams {
  /// ArtistList params
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  const ArtistListLoad({
    /// ArtistList params
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  List<Object?> get props => [ofDance, ofFigure, ofVideo];

  @override
  String toString() {
    return 'ArtistListLoad{'
        'ofDance: $ofDance, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo'
        '}';
  }
}

class ArtistListLoadMore extends ArtistListEvent {
  const ArtistListLoadMore();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ArtistListLoadMore{}';
}

class ArtistListRefresh extends ArtistListEvent {
  const ArtistListRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ArtistListRefresh{}';
}

class ArtistListSelect extends ArtistListEvent {
  final String artistId;

  const ArtistListSelect({
    required this.artistId,
  });

  @override
  List<Object?> get props => [artistId];

  @override
  String toString() => 'ArtistListSelect{'
      'artistId: $artistId'
      '}';
}

class ArtistListUnselect extends ArtistListEvent {
  final String? artistId;

  const ArtistListUnselect({
    this.artistId,
  });

  @override
  List<Object?> get props => [artistId];

  @override
  String toString() => 'ArtistListUnselect{'
      'artistId: $artistId'
      '}';
}

class ArtistListDelete extends ArtistListEvent {
  const ArtistListDelete();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ArtistListDelete{'
      '}';
}
