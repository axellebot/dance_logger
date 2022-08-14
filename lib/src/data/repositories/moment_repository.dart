import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplMomentRepository implements MomentRepository {
  final MomentDataStoreFactory factory;

  ImplMomentRepository({required this.factory});

  @override
  FutureOr<MomentEntity> save(MomentEntity entity) async {
    return await factory.databaseDataStore
        .saveMoment(entity as MomentDataModel);
  }

  @override
  FutureOr<MomentEntity> getById(
    String momentId, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($momentId)');
    final dataModel = await factory.databaseDataStore.getMoment(momentId);
    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String momentId) async {
    if (kDebugMode) print('$runtimeType:deleteById($momentId)');
    await factory.databaseDataStore.deleteMoment(momentId);
  }

  @override
  FutureOr<List<MomentEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getList()');

    final dataModels = await factory.databaseDataStore.getMoments(
      offset: offset,
    );

    return dataModels;
  }

  @override
  FutureOr<List<MomentEntity>> getMomentsOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getMomentsOfFigure($figureId)');

    final dataModels = await factory.databaseDataStore.getMomentsOfFigure(
      figureId,
      offset: offset,
    );

    return dataModels;
  }

  @override
  FutureOr<List<MomentEntity>> getMomentsOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getMomentsOfVideo($videoId)');
    final dataModels = await factory.databaseDataStore.getMomentsOfVideo(
      videoId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<MomentEntity>> getMomentsOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getMomentsOfArtist($artistId)');
    final dataModels = await factory.databaseDataStore.getMomentsOfArtist(
      artistId,
      offset: offset,
    );
    return dataModels;
  }
}
