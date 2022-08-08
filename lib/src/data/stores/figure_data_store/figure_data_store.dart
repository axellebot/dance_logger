import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';

abstract class FigureDataStore {
  FutureOr<FigureDataModel> saveFigure(FigureDataModel figureModel);

  FutureOr<FigureDataModel> getFigure(String figureId);

  FutureOr<void> deleteFigure(String figureId);

  FutureOr<List<FigureDataModel>> getFigures({
    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<FigureDataModel>> getFiguresOfArtist(
    String artistId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<FigureDataModel>> getFiguresOfDance(
    String danceId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<FigureDataModel>> getFiguresOfVideo(
    String videoId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });
}
