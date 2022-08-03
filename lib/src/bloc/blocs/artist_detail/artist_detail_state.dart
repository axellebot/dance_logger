import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

enum ArtistDetailStatus { initial, loading, success, failure }

class ArtistDetailState extends Equatable {
  final ArtistDetailStatus status;
  final ArtistViewModel? artist;
  final Error? error;

  const ArtistDetailState({
    this.status = ArtistDetailStatus.loading,
    this.artist,
    this.error,
  }) : super();

  @override
  List<Object?> get props => [status, artist];

  ArtistDetailState copyWith({
    ArtistDetailStatus? status,
    ArtistViewModel? artist,
    Error? error,
  }) {
    return ArtistDetailState(
      status: status ?? this.status,
      artist: artist ?? this.artist,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'ArtistDetailState{'
        'status: $status, '
        'artist: $artist, '
        'error: $error'
        '}';
  }
}
