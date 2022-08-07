import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplTimeRepository implements TimeRepository {
  final String _tag = '$ImplTimeRepository';

  final MomentDataStoreFactory factory;

  ImplTimeRepository({required this.factory});

  @override
  FutureOr<MomentEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$_tag:getById($id)');

    final dataModel = await factory.databaseDataStore.getMoment(id);

    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$_tag:deleteById($id)');
    await factory.databaseDataStore.deleteMoment(id);
  }

  @override
  FutureOr<List<MomentEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getList()');

    final dataModels = await factory.databaseDataStore.getMoments(
      offset: offset,
    );

    return dataModels;
  }

  @override
  FutureOr<List<MomentEntity>> getTimesOfFigure(
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
  FutureOr<List<MomentEntity>> getTimesOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getTimesOfVideo($videoId)');
    final dataModels = await factory.databaseDataStore.getMomentsOfVideo(
      videoId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<MomentEntity>> getTimesOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getTimesOfArtist($artistId)');
    final dataModels = await factory.databaseDataStore.getMomentsOfArtist(
      artistId,
      offset: offset,
    );
    return dataModels;
  }
}
