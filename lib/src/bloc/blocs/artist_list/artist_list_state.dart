import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

import 'artist_list_params.dart';

enum ArtistListStatus { initial, loading, success, failure }

class ArtistListState extends Equatable implements ArtistListParams {
  final ArtistListStatus status;

  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final Error? error;

  final List<ArtistViewModel> artists;
  final bool hasReachedMax;

  const ArtistListState({
    this.status = ArtistListStatus.initial,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
    this.artists = const <ArtistViewModel>[],
    this.hasReachedMax = false,
    this.error,
  });

  @override
  List<Object?> get props =>
      [status, ofDance, ofFigure, ofVideo, artists, hasReachedMax, error];

  ArtistListState copyWith({
    ArtistListStatus? status,
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    List<ArtistViewModel>? artists,
    bool? hasReachedMax,
    Error? error,
  }) {
    return ArtistListState(
      status: status ?? this.status,
      ofDance: ofDance ?? this.ofDance,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      artists: artists ?? this.artists,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'ArtistListLoaded{'
        'status: $status, '
        'ofDance: $ofDance, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo, '
        'artists: $artists, '
        'hasReachedMax: $hasReachedMax'
        'error: $error'
        '}';
  }
}
