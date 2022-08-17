import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum ArtistListStatus { initial, loading, refreshing, success, failure }

class ArtistListState extends Equatable implements ArtistListParams {
  final ArtistListStatus status;

  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<ArtistViewModel> artists;
  final bool hasReachedMax;
  final List<String> selectedArtists;
  final Error? error;

  const ArtistListState({
    this.status = ArtistListStatus.initial,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
    this.artists = const <ArtistViewModel>[],
    this.hasReachedMax = false,
    this.selectedArtists = const <String>[],
    this.error,
  });

  @override
  List<Object?> get props => [
    status,
    ofDance,
    ofFigure,
    ofVideo,
    artists,
    hasReachedMax,
    selectedArtists,
    error,
  ];

  ArtistListState copyWith({
    ArtistListStatus? status,
    String? ofDance,
    String? ofFigure,
    String? ofVideo,
    List<ArtistViewModel>? artists,
    bool? hasReachedMax,
    List<String>? selectedArtists,
    Error? error,
  }) {
    return ArtistListState(
      status: status ?? this.status,
      ofDance: ofDance ?? this.ofDance,
      ofFigure: ofFigure ?? this.ofFigure,
      ofVideo: ofVideo ?? this.ofVideo,
      artists: artists ?? this.artists,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedArtists: selectedArtists ?? this.selectedArtists,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'ArtistListState{'
        'status: $status, '
        'ofDance: $ofDance, '
        'ofFigure: $ofFigure, '
        'ofVideo: $ofVideo, '
        'artists: $artists, '
        'hasReachedMax: $hasReachedMax, '
        'selectedArtists: $selectedArtists, '
        'error: $error'
        '}';
  }
}
