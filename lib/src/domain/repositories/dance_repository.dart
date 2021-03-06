import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for dance purpose
abstract class DanceRepository extends EntityRepository<DanceEntity> {
  FutureOr<List<DanceEntity>> getDancesOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });
}
