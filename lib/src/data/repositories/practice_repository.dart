import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplPracticeRepository extends PracticeRepository {
  final PracticeDataStoreFactory factory;

  ImplPracticeRepository({required this.factory});

  @override
  FutureOr<PracticeEntity> save(PracticeEntity entity) async {
    if (kDebugMode) print('$runtimeType:save($entity)');
    return await factory.databaseDataStore
        .savePractice(entity as PracticeDataModel);
  }

  @override
  FutureOr<PracticeEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($id)');
    return await factory.databaseDataStore.getPractice(id);
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$runtimeType:deleteById($id)');
    await factory.databaseDataStore.deletePractice(id);
  }

  @override
  FutureOr<List<PracticeEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getList()');
    return await factory.databaseDataStore.getPractices(
      offset: offset,
    );
  }

  @override
  FutureOr<List<PracticeEntity>> getPracticesOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getPracticesOfFigure($figureId)');
    return await factory.databaseDataStore.getPracticesOfFigure(
      figureId,
      offset: offset,
    );
  }

  @override
  FutureOr<List<PracticeEntity>> getPracticesOfUser(
    String userId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getPracticesOfUser($userId)');
    return await factory.databaseDataStore.getPracticesOfUser(
      userId,
      offset: offset,
    );
  }
}
