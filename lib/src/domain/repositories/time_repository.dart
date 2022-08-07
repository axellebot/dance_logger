import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for moments
abstract class MomentRepository extends EntityRepository<MomentEntity> {
  FutureOr<List<MomentEntity>> getMomentsOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<MomentEntity>> getMomentsOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<MomentEntity>> getMomentsOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });
}
