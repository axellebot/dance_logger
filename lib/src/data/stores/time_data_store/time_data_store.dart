import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';

abstract class TimeDataStore {
  FutureOr<TimeDataModel> setTime(TimeDataModel timeModel);

  FutureOr<TimeDataModel> getTime(String timeId);

  FutureOr<void> deleteTime(String timeId);

  FutureOr<List<TimeDataModel>> getTimes({
    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<TimeDataModel>> getTimesOfFigure(
    String figureId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<TimeDataModel>> getTimesOfVideo(
    String videoId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<TimeDataModel>> getTimesOfArtist(
    String artistId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });
}
