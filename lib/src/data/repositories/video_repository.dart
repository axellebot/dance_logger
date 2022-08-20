import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplVideoRepository extends VideoRepository {
  final VideoDataStoreFactory factory;

  ImplVideoRepository({required this.factory});

  @override
  FutureOr<VideoEntity> save(VideoEntity entity) async {
    return await factory.databaseDataStore.saveVideo(entity as VideoDataModel);
  }

  @override
  FutureOr<VideoEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$runtimeType:getById($id)');

    VideoDataModel dataModel;

    dataModel = await factory.databaseDataStore.getVideo(id);

    return dataModel;
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
    final dataModels = await factory.databaseDataStore.getVideos(
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<VideoEntity>> getListOfSearch(
    String search, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getListOfSearch($search)');
    final dataModels = await factory.databaseDataStore.getVideosOfSearch(
      search,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<VideoEntity>> getVideosOfArtist(
    String artistId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfArtist($artistId)');
    final dataModels = await factory.databaseDataStore.getVideosOfArtist(
      artistId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<VideoEntity>> getVideosOfFigure(
    String figureId, {
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfFigure($figureId)');
    final dataModels = await factory.databaseDataStore.getVideosOfFigure(
      figureId,
      offset: offset,
    );
    return dataModels;
  }

  @override
  FutureOr<List<VideoEntity>> getVideosOfDance(String danceId,
      {required Offset offset}) async {
    if (kDebugMode) print('$runtimeType:getVideosOfDance($danceId)');
    final dataModels = await factory.databaseDataStore.getVideosOfDance(
      danceId,
      offset: offset,
    );
    return dataModels;
  }
}
