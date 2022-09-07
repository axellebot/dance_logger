import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplDanceRepository extends DanceRepository {
  final DanceDataStoreFactory factory;

  ImplDanceRepository({
    required this.factory,
  });

  @override
  FutureOr<DanceEntity> save(DanceEntity entity) async {
    if (kDebugMode) print('$runtimeType:save($entity)');
    return await factory.databaseDataStore.saveDance(entity as DanceDataModel);
  }

  @override
  FutureOr<DanceEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($id)');
    return await factory.databaseDataStore.getDance(id);
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
    return await factory.databaseDataStore.getDances(
      offset: offset,
    );
  }

  @override
  FutureOr<List<DanceEntity>> getListOfSearch(
    String search, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getListOfSearch($search)');
    return await factory.databaseDataStore.getDancesOfSearch(
      search,
      offset: offset,
    );
  }

  @override
  FutureOr<List<DanceEntity>> getDancesOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getDancesOfArtist($artistId)');
    return await factory.databaseDataStore.getDancesOfArtist(
      artistId,
      offset: offset,
    );
  }

  @override
  FutureOr<List<DanceEntity>> getDancesOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getDancesOfVideo($videoId)');
    final dataModels = await factory.databaseDataStore.getDancesOfVideo(
      videoId,
      offset: offset,
    );
    return dataModels;
  }
}
