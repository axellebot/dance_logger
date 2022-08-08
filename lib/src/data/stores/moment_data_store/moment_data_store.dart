import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';

abstract class MomentDataStore {
  FutureOr<MomentDataModel> saveMoment(MomentDataModel momentModel);

  FutureOr<MomentDataModel> getMoment(String momentId);

  FutureOr<void> deleteMoment(String momentId);

  FutureOr<List<MomentDataModel>> getMoments({
    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<MomentDataModel>> getMomentsOfFigure(
    String figureId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<MomentDataModel>> getMomentsOfVideo(
    String videoId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<MomentDataModel>> getMomentsOfArtist(
    String artistId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });
}
