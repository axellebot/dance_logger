import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum ArtistDetailStatus {
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

class ArtistDetailState extends Equatable {
  final ArtistDetailStatus status;
  final String? ofArtistId;
  final ArtistViewModel? artist;
  final Error? error;

  const ArtistDetailState({
    this.status = ArtistDetailStatus.initial,
    this.ofArtistId,
    this.artist,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofArtistId,
        artist,
        error,
      ];

  ArtistDetailState copyWith({
    ArtistDetailStatus? status,
    Optional<String>? ofArtistId,
    Optional<ArtistViewModel>? artist,
    Optional<Error>? error,
  }) {
    return ArtistDetailState(
      status: status ?? this.status,
      ofArtistId: ofArtistId != null ? ofArtistId.orNull : this.ofArtistId,
      artist: artist != null ? artist.orNull : this.artist,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'ArtistDetailState{'
      'status: $status, '
      'ofArtistId: $ofArtistId, '
      'artist: $artist, '
      'error: $error'
      '}';
}
