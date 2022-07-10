import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplPracticeRepository extends PracticeRepository {
  final String _tag = '$ImplPracticeRepository';

  final PracticeDataStoreFactory factory;

  ImplPracticeRepository({required this.factory});

  @override
  FutureOr<PracticeEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$_tag:getById($id)');
    final dataModel = await factory.databaseDataStore.getPractice(id);
    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$_tag:deleteById($id)');
    await factory.databaseDataStore.deletePractice(id);
  }

  @override
  FutureOr<List<PracticeEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getList()');
    final dataModels = await factory.databaseDataStore.getPractices(
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<PracticeEntity>> getPracticesOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getPracticesOfFigure($figureId)');
    final dataModels = factory.databaseDataStore.getPracticesOfFigure(
      figureId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<PracticeEntity>> getPracticesOfUser(
    String userId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getPracticesOfUser($userId)');
    final dataModels = await factory.databaseDataStore.getPracticesOfUser(
      userId,
      offset: offset,
    );
    return dataModels;
  }
}
