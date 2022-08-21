import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

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
  final ArtistViewModel? initialArtist;
  final String? artistName;
  final String? artistImageUrl;
  final Error? error;

  const ArtistEditState({
    this.status = ArtistEditStatus.initial,
    this.initialArtist,
    this.artistName,
    this.artistImageUrl,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [
        status,
        initialArtist,
        artistName,
        artistImageUrl,
        error,
      ];

  ArtistEditState copyWith({
    ArtistEditStatus? status,
    ArtistViewModel? initialArtist,
    String? artistName,
    String? artistImageUrl,
    Error? error,
  }) {
    return ArtistEditState(
      status: status ?? this.status,
      initialArtist: initialArtist ?? this.initialArtist,
      artistName: artistName ?? this.artistName,
      artistImageUrl: artistImageUrl ?? this.artistImageUrl,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'ArtistEditLoaded{'
      'status: $status, '
      'initialArtist: $initialArtist, '
      'artistName: $artistName, '
      'artistImageUrl: $artistImageUrl, '
      'error: $error'
      '}';
}
