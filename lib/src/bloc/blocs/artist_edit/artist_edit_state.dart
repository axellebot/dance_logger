import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum ArtistEditStatus {
  initial,
  loading,
  ready,
  editSuccess,
  deleteSuccess,
  failure
}

class ArtistEditState extends Equatable {
  final ArtistEditStatus status;
  final String? ofId;
  final ArtistViewModel? initialArtist;
  final String? artistName;
  final Optional<String>? artistImageUrl;
  final Error? error;

  const ArtistEditState({
    this.status = ArtistEditStatus.initial,
    this.ofId,
    this.initialArtist,
    this.artistName,
    this.artistImageUrl,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        ofId,
        initialArtist,
        artistName,
        artistImageUrl,
        error,
      ];

  ArtistEditState copyWith({
    ArtistEditStatus? status,
    Optional<String>? ofId,
    Optional<ArtistViewModel>? initialArtist,
    Optional<String>? artistName,
    Optional<String>? artistImageUrl,
    Optional<Error>? error,
  }) {
    return ArtistEditState(
      status: status ?? this.status,
      ofId: ofId != null ? ofId.orNull : this.ofId,
      initialArtist:
          initialArtist != null ? initialArtist.orNull : this.initialArtist,
      artistName: artistName != null ? artistName.orNull : this.artistName,
      artistImageUrl: artistImageUrl ?? this.artistImageUrl,
      error: error != null ? error.orNull : this.error,
    );
  }

  @override
  String toString() => 'ArtistEditLoaded{'
      'status: $status, '
      'ofId: $ofId, '
      'initialArtist: $initialArtist, '
      'artistName: $artistName, '
      'artistImageUrl: $artistImageUrl, '
      'error: $error'
      '}';
}
