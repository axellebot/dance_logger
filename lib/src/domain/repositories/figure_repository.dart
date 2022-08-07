import 'dart:async';

import 'package:dance/domain.dart';

/// Repository interface for figures
abstract class FigureRepository extends EntityRepository<FigureEntity> {
  FutureOr<List<FigureEntity>> getFiguresOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<FigureEntity>> getFiguresOfDance(
    String danceId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });

  FutureOr<List<FigureEntity>> getFiguresOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  });
}
