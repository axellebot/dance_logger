import 'package:dance/presentation.dart';
import 'package:dance/src/bloc/blocs/artist_list/artist_list_params.dart';
import 'package:equatable/equatable.dart';

abstract class ArtistListState extends Equatable {
  const ArtistListState();

  @override
  String toString() => 'ArtistListState{}';
}

class ArtistListUninitialized extends ArtistListState {
  const ArtistListUninitialized();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ArtistListUninitialized{}';
}

class ArtistListRefreshing extends ArtistListState {
  const ArtistListRefreshing();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ArtistListRefreshing{}';
}

class ArtistListLoaded extends ArtistListState implements ArtistListParams {
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<ArtistViewModel> artists;
  final bool hasReachedMax;

  const ArtistListLoaded({
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
    required this.artists,
    required this.hasReachedMax,
  });

  @override
  List<Object?> get props =>
      [ofDance, ofFigure, ofVideo, artists, hasReachedMax];

  ArtistListLoaded copyWith({
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    List<ArtistViewModel>? artists,
    bool? hasReachedMax,
  }) {
    return ArtistListLoaded(
      ofDance: ofDance ?? this.ofDance,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      artists: artists ?? this.artists,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return 'ArtistListLoaded{'
        'ofDance: $ofDance, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo, '
        'artists: $artists, '
        'hasReachedMax: $hasReachedMax'
        '}';
  }
}
