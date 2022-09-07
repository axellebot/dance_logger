import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';
import 'package:quiver/core.dart';

enum ArtistDetailStatus {
  initial,
  refreshing,
  refreshingSuccess,
  refreshingFailure,
  deleteSuccess,
  deleteFailure,
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
  List<Object?> get props => [
        status,
        ofId,
        artist,
        error,
      ];

  ArtistDetailState copyWith({
    ArtistDetailStatus? status,
    Optional<String>? ofId,
    Optional<ArtistViewModel>? artist,
    Optional<Error>? error,
  }) {
    return ArtistDetailState(
      status: status ?? this.status,
      ofId: ofId?.orNull ?? this.ofId,
      artist: artist?.orNull ?? this.artist,
      error: error?.orNull ?? this.error,
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
