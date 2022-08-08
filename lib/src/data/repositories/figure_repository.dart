import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplFigureRepository extends FigureRepository {
  final String _tag = '$ImplFigureRepository';

  final FigureDataStoreFactory factory;

  ImplFigureRepository({required this.factory});

  @override
  FutureOr<FigureEntity> save(FigureEntity entity) async {
    return await factory.databaseDataStore
        .saveFigure(entity as FigureDataModel);
  }

  @override
  FutureOr<FigureEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$_tag:getById($id)');
    final dataModel = await factory.databaseDataStore.getFigure(id);
    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$_tag:deleteById($id)');
    await factory.databaseDataStore.deleteFigure(id);
  }

  @override
  FutureOr<List<FigureEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getList()');
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
    if (kDebugMode) print('$_tag:getFiguresOfArtist($artistId)');
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
    if (kDebugMode) print('$_tag:getFiguresOfVideo($videoId)');
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
    if (kDebugMode) print('$_tag:getFiguresOfDance($danceId)');
    final dataModels = await factory.databaseDataStore.getFiguresOfDance(
      danceId,
      offset: offset,
    );
    return dataModels;
  }
}
