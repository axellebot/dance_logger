import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for timecode purpose
abstract class TimeRepository extends EntityRepository<TimeEntity> {
  FutureOr<List<TimeEntity>> getTimesOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<TimeEntity>> getTimesOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<TimeEntity>> getTimesOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });
}
