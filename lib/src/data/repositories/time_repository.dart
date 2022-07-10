import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplTimeRepository implements TimeRepository {
  final String _tag = '$ImplTimeRepository';

  final TimeDataStoreFactory factory;

  ImplTimeRepository({required this.factory});

  @override
  FutureOr<TimeEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$_tag:getById($id)');

    final dataModel = await factory.databaseDataStore.getTime(id);

    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$_tag:deleteById($id)');
    await factory.databaseDataStore.deleteTime(id);
  }

  @override
  FutureOr<List<TimeEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getList()');

    final dataModels = await factory.databaseDataStore.getTimes(
      offset: offset,
    );

    return dataModels;
  }

  @override
  FutureOr<List<TimeEntity>> getTimesOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getTimesOfFigure($figureId)');

    final dataModels = await factory.databaseDataStore.getTimesOfFigure(
      figureId,
      offset: offset,
    );

    return dataModels;
  }

  @override
  FutureOr<List<TimeEntity>> getTimesOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getTimesOfVideo($videoId)');
    final dataModels = await factory.databaseDataStore.getTimesOfVideo(
      videoId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<TimeEntity>> getTimesOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getTimesOfArtist($artistId)');
    final dataModels = await factory.databaseDataStore.getTimesOfArtist(
      artistId,
      offset: offset,
    );
    return dataModels;
  }
}
