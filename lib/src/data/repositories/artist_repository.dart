import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplArtistRepository extends ArtistRepository {
  final ArtistDataStoreFactory factory;

  ImplArtistRepository({
    required this.factory,
  });

  @override
  FutureOr<ArtistEntity> save(ArtistEntity entity) async {
    return await factory.databaseDataStore
        .saveArtist(entity as ArtistDataModel);
  }

  @override
  FutureOr<ArtistEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($id)');
    final dataModel = await factory.databaseDataStore.getArtist(id);
    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$runtimeType:deleteById($id)');
    await factory.databaseDataStore.deleteArtist(id);
  }

  @override
  FutureOr<List<ArtistEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getList()');
    final dataModels = await factory.databaseDataStore.getArtists(
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<ArtistEntity>> getArtistsOfDance(
    String danceId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfDance($danceId)');
    final dataModels = await factory.databaseDataStore.getArtistsOfDance(
      danceId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<ArtistEntity>> getArtistOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getListFromVideo($videoId)');
    final dataModels = await factory.databaseDataStore.getArtistsOfVideo(
      videoId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<ArtistEntity>> getArtistsOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfFigure($figureId)');
    final dataModels = await factory.databaseDataStore.getArtistsOfFigure(
      figureId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<ArtistEntity>> getArtistsOfTime(
    String timeId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfTime($timeId)');
    final dataModels = await factory.databaseDataStore.getArtistsOfMoment(
      timeId,
      offset: offset,
    );
    return dataModels;
  }
}
