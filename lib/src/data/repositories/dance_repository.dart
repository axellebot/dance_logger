import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplDanceRepository extends DanceRepository {
  final DanceDataStoreFactory factory;

  ImplDanceRepository({required this.factory});

  @override
  FutureOr<DanceEntity> save(DanceEntity entity) async {
    return await factory.databaseDataStore.saveDance(entity as DanceDataModel);
  }

  @override
  FutureOr<DanceEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($id)');

    DanceDataModel dataModel;

    dataModel = await factory.databaseDataStore.getDance(id);

    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$runtimeType:deleteById($id)');
    await factory.databaseDataStore.deleteDance(id);
  }

  @override
  FutureOr<List<DanceEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getList()');
    final dataModels = await factory.databaseDataStore.getDances(
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<DanceEntity>> getDancesOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getDancesOfArtist($artistId)');
    final dataModels = await factory.databaseDataStore.getDancesOfArtist(
      artistId,
      offset: offset,
    );
    return dataModels;
  }
}
