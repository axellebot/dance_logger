import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplFigureRepository extends FigureRepository {
  final FigureDataStoreFactory factory;

  ImplFigureRepository({required this.factory});

  @override
  FutureOr<FigureEntity> save(FigureEntity entity) async {
    if (kDebugMode) print('$runtimeType:save($entity)');
    return await factory.databaseDataStore
        .saveFigure(entity as FigureDataModel);
  }

  @override
  FutureOr<FigureEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($id)');
    final dataModel = await factory.databaseDataStore.getFigure(id);
    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$runtimeType:deleteById($id)');
    await factory.databaseDataStore.deleteFigure(id);
  }

  @override
  FutureOr<List<FigureEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getList()');
    final dataModels = await factory.databaseDataStore.getFigures(
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<FigureEntity>> getFiguresOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getFiguresOfArtist($artistId)');
    final dataModels = await factory.databaseDataStore.getFiguresOfArtist(
      artistId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<FigureEntity>> getFiguresOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getFiguresOfVideo($videoId)');
    final dataModels = await factory.databaseDataStore.getFiguresOfVideo(
      videoId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<FigureEntity>> getFiguresOfDance(
    String danceId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getFiguresOfDance($danceId)');
    final dataModels = await factory.databaseDataStore.getFiguresOfDance(
      danceId,
      offset: offset,
    );
    return dataModels;
  }
}
