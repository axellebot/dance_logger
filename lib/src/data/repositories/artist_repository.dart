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
    if (kDebugMode) print('$runtimeType:save($entity)');
    return await factory.databaseDataStore
        .saveArtist(entity as ArtistDataModel);
  }

  @override
  FutureOr<ArtistEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($id)');
    return await factory.databaseDataStore.getArtist(id);
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
    return await factory.databaseDataStore.getArtists(
      offset: offset,
    );
  }

  @override
  FutureOr<List<ArtistEntity>> getListOfSearch(
    String search, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getListOfSearch($search)');
    return await factory.databaseDataStore.getArtistsOfSearch(
      search,
      offset: offset,
    );
  }

  @override
  FutureOr<List<ArtistEntity>> getArtistsOfDance(
    String danceId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfDance($danceId)');
    return await factory.databaseDataStore.getArtistsOfDance(
      danceId,
      offset: offset,
    );
  }

  @override
  FutureOr<List<ArtistEntity>> getArtistsOfVideo(
    String videoId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfVideo($videoId)');
    return await factory.databaseDataStore.getArtistsOfVideo(
      videoId,
      offset: offset,
    );
  }

  @override
  FutureOr<List<ArtistEntity>> getArtistsOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfFigure($figureId)');
    return await factory.databaseDataStore.getArtistsOfFigure(
      figureId,
      offset: offset,
    );
  }

  @override
  FutureOr<List<ArtistEntity>> getArtistsOfMoment(
    String timeId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfMoment($timeId)');
    return await factory.databaseDataStore.getArtistsOfMoment(
      timeId,
      offset: offset,
    );
  }
}
