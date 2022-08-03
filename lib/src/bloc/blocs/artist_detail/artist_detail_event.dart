import 'package:dance/bloc.dart';
import 'package:equatable/equatable.dart';

/// [ArtistEvent] that must be dispatch to [ArtistBloc]
abstract class ArtistEvent extends Equatable {
  const ArtistEvent() : super();

  @override
  String toString() => 'ArtistEvent{}';
}

class ArtistLoad extends ArtistEvent {
  final String artistId;

  const ArtistLoad({required this.artistId}) : super();

  @override
  String toString() {
    return 'ArtistLoad{'
        'artistId: $artistId'
        '}';
  }

  @override
  List<Object?> get props => [artistId];
}
