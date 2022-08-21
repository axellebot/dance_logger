import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for videos
abstract class VideoRepository extends EntityRepository<VideoEntity> {
  FutureOr<List<VideoEntity>> getListOfSearch(
    String search, {
    required Offset offset, // Pagination

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<VideoEntity>> getVideosOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<VideoEntity>> getVideosOfDance(
    String danceId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<VideoEntity>> getVideosOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });
}
