import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplVideoRepository extends VideoRepository {
  final VideoDataStoreFactory factory;

  ImplVideoRepository({required this.factory});

  @override
  FutureOr<VideoEntity> save(VideoEntity entity) async {
    if (kDebugMode) print('$runtimeType:save($entity)');
    return await factory.databaseDataStore.saveVideo(entity as VideoDataModel);
  }

  @override
  FutureOr<VideoEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($id)');
    return await factory.databaseDataStore.getVideo(id);
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$runtimeType:deleteById($id)');
    await factory.databaseDataStore.deleteVideo(id);
  }

  @override
  FutureOr<List<VideoEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getList()');
    return await factory.databaseDataStore.getVideos(
      offset: offset,
    );
  }

  @override
  FutureOr<List<VideoEntity>> getListOfSearch(
    String search, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getListOfSearch($search)');
    return await factory.databaseDataStore.getVideosOfSearch(
      search,
      offset: offset,
    );
  }

  @override
  FutureOr<List<VideoEntity>> getVideosOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfArtist($artistId)');
    return await factory.databaseDataStore.getVideosOfArtist(
      artistId,
      offset: offset,
    );
  }

  @override
  FutureOr<List<VideoEntity>> getVideosOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfFigure($figureId)');
    return await factory.databaseDataStore.getVideosOfFigure(
      figureId,
      offset: offset,
    );
  }

  @override
  FutureOr<List<VideoEntity>> getVideosOfDance(
    String danceId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfDance($danceId)');
    return await factory.databaseDataStore.getVideosOfDance(
      danceId,
      offset: offset,
    );
  }
}
