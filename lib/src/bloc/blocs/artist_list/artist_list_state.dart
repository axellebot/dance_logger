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
  final String? ofDanceId;
  @override
  final String? ofFigureId;
  @override
  final String? ofVideoId;

  final List<ArtistViewModel> artists;
  final bool hasReachedMax;
  final List<ArtistViewModel> selectedArtists;
  final Error? error;

  const ArtistListState({
    this.status = ArtistListStatus.initial,
    this.ofSearch,
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,
    this.artists = const <ArtistViewModel>[],
    this.hasReachedMax = false,
    this.selectedArtists = const <ArtistViewModel>[],
    this.error,
  }) : assert(ofSearch == null ||
            (ofDanceId == null && ofFigureId == null && ofVideoId == null));

  @override
  List<Object?> get props => [
        status,
        ofSearch,
        ofDanceId,
        ofFigureId,
        ofVideoId,
        artists,
        hasReachedMax,
        selectedArtists,
        error,
      ];

  ArtistListState copyWith({
    ArtistListStatus? status,
    Optional<String>? ofSearch,
    Optional<String>? ofDanceId,
    Optional<String>? ofFigureId,
    Optional<String>? ofVideoId,
    List<ArtistViewModel>? artists,
    bool? hasReachedMax,
    List<ArtistViewModel>? selectedArtists,
    Optional<Error>? error,
  }) {
    return ArtistListState(
      status: status ?? this.status,
      ofSearch: ofSearch != null ? ofSearch.orNull : this.ofSearch,
      ofDanceId: ofDanceId != null ? ofDanceId.orNull : this.ofDanceId,
      ofFigureId: ofFigureId != null ? ofFigureId.orNull : this.ofFigureId,
      ofVideoId: ofVideoId != null ? ofVideoId.orNull : this.ofVideoId,
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
      'ofDanceId: $ofDanceId, '
      'ofFigureId: $ofFigureId, '
      'ofVideoId: $ofVideoId, '
      'artists: $artists, '
      'hasReachedMax: $hasReachedMax, '
      'selectedArtists: $selectedArtists, '
      'error: $error'
      '}';
}
