import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:equatable/equatable.dart';

/// [ArtistDetailEvent] that must be dispatch to [ArtistDetailBloc]
abstract class ArtistDetailEvent extends Equatable {
  const ArtistDetailEvent() : super();

  @override
  String toString() => 'ArtistDetailEvent{}';
}

class ArtistDetailLazyLoad extends ArtistDetailEvent {
  final ArtistViewModel artist;

  const ArtistDetailLazyLoad({
    required this.artist,
  }) : super();

  @override
  String toString() => 'ArtistDetailLoad{'
      'artist: $artist'
      '}';

  @override
  List<Object?> get props => [artist];
}

class ArtistDetailLoad extends ArtistDetailEvent {
  final String artistId;

  const ArtistDetailLoad({
    required this.artistId,
  }) : super();

  @override
  String toString() => 'ArtistDetailLoad{'
      'artistId: $artistId'
      '}';

  @override
  List<Object?> get props => [artistId];
}

class ArtistDetailRefresh extends ArtistDetailEvent {
  const ArtistDetailRefresh();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ArtistDetailRefresh{}';
}

class ArtistDetailDelete extends ArtistDetailEvent {
  const ArtistDetailDelete() : super();

  @override
  String toString() => 'ArtistDetailDelete{}';

  @override
  List<Object?> get props => [];
}
