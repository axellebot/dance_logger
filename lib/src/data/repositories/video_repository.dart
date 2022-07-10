import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';

class ImplVideoRepository extends VideoRepository {
  final String _tag = '$ImplVideoRepository';

  final VideoDataStoreFactory factory;

  ImplVideoRepository({required this.factory});

  @override
  FutureOr<VideoEntity> getById(
    String id, {
    bool force = false,
  }) async {
    if (kDebugMode) print('$_tag:getById($id)');

    VideoDataModel dataModel;

    dataModel = await factory.databaseDataStore.getVideo(id);

    return dataModel;
  }

  @override
  FutureOr<void> deleteById(String id) async {
    if (kDebugMode) print('$_tag:deleteById($id)');
    await factory.databaseDataStore.deleteVideo(id);
  }

  @override
  FutureOr<List<VideoEntity>> getList({
    required Offset offset,

    /// TODO: Add filters
    /// TODO: Add sort
  }) async {
    if (kDebugMode) print('$_tag:getList()');
    final dataModels = await factory.databaseDataStore.getVideos(
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
    if (kDebugMode) print('$_tag:getVideosOfArtist($artistId)');
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
    if (kDebugMode) print('$_tag:getVideosOfFigure($figureId)');
    final dataModels = await factory.databaseDataStore.getVideosOfFigure(
      figureId,
      offset: offset,
    );
    return dataModels;
  }
}
