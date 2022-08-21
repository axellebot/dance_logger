import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [ArtistEditEvent] that must be dispatch to [ArtistEditBloc]
abstract class ArtistEditEvent extends Equatable {
  const ArtistEditEvent() : super();

  @override
  String toString() => 'ArtistEditEvent{}';
}

class ArtistEditStart extends ArtistEditEvent {
  final String? artistId;

  const ArtistEditStart({
    this.artistId,
  }) : super();

  @override
  String toString() => 'ArtistEditStart{'
      'danceId: $artistId'
      '}';

  @override
  List<Object?> get props => [artistId];
}

class ArtistEditChangeName extends ArtistEditEvent {
  final String artistName;

  const ArtistEditChangeName({required this.artistName}) : super();

  @override
  String toString() => 'ArtistEditChangeName{'
      'artistName: $artistName'
      '}';

  @override
  List<Object?> get props => [artistName];
}

class ArtistEditChangeImageUrl extends ArtistEditEvent {
  final String artistImageUrl;

  const ArtistEditChangeImageUrl({required this.artistImageUrl}) : super();

  @override
  String toString() => 'ArtistEditChangeName{'
      'artistImageUrl: $artistImageUrl'
      '}';

  @override
  List<Object?> get props => [artistImageUrl];
}

class ArtistEditSubmit extends ArtistEditEvent {
  const ArtistEditSubmit() : super();

  @override
  String toString() => 'ArtistEditSubmit{}';

  @override
  List<Object?> get props => [];
}

class ArtistEditDelete extends ArtistEditEvent {
  const ArtistEditDelete() : super();

  @override
  String toString() => 'ArtistEditDelete{}';

  @override
  List<Object?> get props => [];
}
