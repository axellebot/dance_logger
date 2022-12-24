import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum ArtistListStatus {
  initial,
  loading,
  loadingSuccess,
  loadingFailure,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
}

class ArtistListState extends Equatable implements ArtistListParams {
  final ArtistListStatus status;

  @override
  final String? ofSearch;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

  final List<ArtistViewModel> artists;
  final bool hasReachedMax;
  final List<ArtistViewModel> selectedArtists;
  final Error? error;

  const ArtistListState({
    this.status = ArtistListStatus.initial,
    this.ofSearch,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
    this.artists = const <ArtistViewModel>[],
    this.hasReachedMax = false,
    this.selectedArtists = const <ArtistViewModel>[],
    this.error,
  }) : assert(ofSearch == null ||
            (ofDance == null && ofFigure == null && ofVideo == null));

  @override
  List<Object?> get props => [
        status,
        ofSearch,
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
    Optional<String>? ofSearch,
    Optional<String>? ofDance,
    Optional<String>? ofFigure,
    Optional<String>? ofVideo,
    List<ArtistViewModel>? artists,
    bool? hasReachedMax,
    List<ArtistViewModel>? selectedArtists,
    Optional<Error>? error,
  }) {
    return ArtistListState(
      status: status ?? this.status,
      ofSearch: ofSearch != null ? ofSearch.orNull : this.ofSearch,
      ofDance: ofDance != null ? ofDance.orNull : this.ofDance,
      ofFigure: ofFigure != null ? ofFigure.orNull : this.ofFigure,
      ofVideo: ofVideo != null ? ofVideo.orNull : this.ofVideo,
      artists: artists ?? this.artists,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      selectedArtists: selectedArtists ?? this.selectedArtists,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'ArtistListState{'
      'status: $status, '
      'ofSearch: $ofSearch, '
      'ofDance: $ofDance, '
      'ofFigure: $ofFigure, '
      'ofVideo: $ofVideo, '
      'artists: $artists, '
      'hasReachedMax: $hasReachedMax, '
      'selectedArtists: $selectedArtists, '
      'error: $error'
      '}';
}
