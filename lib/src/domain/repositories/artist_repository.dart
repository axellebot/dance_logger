import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for artists
abstract class ArtistRepository extends EntityRepository<ArtistEntity> {
  FutureOr<List<ArtistEntity>> getArtistsOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<ArtistEntity>> getArtistsOfDance(
    String danceId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<ArtistEntity>> getArtistsOfMoment(
    String timeId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<ArtistEntity>> getArtistsOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });
}
