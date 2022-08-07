import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for timecode purpose
abstract class TimeRepository extends EntityRepository<MomentEntity> {
  FutureOr<List<MomentEntity>> getTimesOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<MomentEntity>> getTimesOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<MomentEntity>> getTimesOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });
}
