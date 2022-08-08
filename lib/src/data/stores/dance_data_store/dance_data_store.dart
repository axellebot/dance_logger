import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';

abstract class DanceDataStore {
  FutureOr<DanceDataModel> saveDance(DanceDataModel danceModel);

  FutureOr<DanceDataModel> getDance(String danceId);

  FutureOr<void> deleteDance(String danceId);

  FutureOr<List<DanceDataModel>> getDances({
    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<DanceDataModel>> getDancesOfArtist(
    String artistId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });
}
