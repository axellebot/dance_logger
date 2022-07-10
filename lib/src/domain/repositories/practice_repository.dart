import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for practice purpose
abstract class PracticeRepository extends EntityRepository<PracticeEntity> {
  FutureOr<List<PracticeEntity>> getPracticesOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<PracticeEntity>> getPracticesOfUser(
    String userId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });
}
