import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

abstract class ArtistState extends Equatable {
  const ArtistState() : super();

  @override
  String toString() => 'ArtistState{}';
}

class ArtistUninitialized extends ArtistState {
  const ArtistUninitialized();

  @override
  List<Object?> get props => [];
}

class ArtistLoading extends ArtistState {
  const ArtistLoading() : super();

  @override
  List<Object?> get props => [];
}

class ArtistLoaded extends ArtistState {
  final ArtistViewModel artist;

  const ArtistLoaded({
    required this.artist,
  }) : super();

  @override
  List<Object?> get props => [artist];

  @override
  String toString() {
    return 'ArtistLoaded{ '
        'artist: $artist'
        ' }';
  }
}

class ArtistFailed extends ArtistState {
  final Error error;

  const ArtistFailed({required this.error}) : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ArtistFailed { '
      'error: $error'
      ' }';
}
