import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for video purpose
abstract class VideoRepository extends EntityRepository<VideoEntity> {
  FutureOr<List<VideoEntity>> getVideosOfArtist(
    String artistId, {
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
