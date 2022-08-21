import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum ArtistDetailStatus {
  initial,
  loading,
  refreshing,
  detailSuccess,
  deleteSuccess,
  failure,
}

class ArtistDetailState extends Equatable {
  final ArtistDetailStatus status;

  final String? ofId;
  final ArtistViewModel? artist;
  final Error? error;

  const ArtistDetailState({
    this.status = ArtistDetailStatus.initial,
    this.ofId,
    this.artist,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [status, ofId, artist, error];

  ArtistDetailState copyWith({
    ArtistDetailStatus? status,
    String? ofId,
    ArtistViewModel? artist,
    Error? error,
  }) {
    return ArtistDetailState(
      status: status ?? this.status,
      ofId: ofId ?? this.ofId,
      artist: artist ?? this.artist,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'ArtistDetailState{'
      'status: $status, '
      'ofId: $ofId, '
      'artist: $artist, '
      'error: $error'
      '}';
}
