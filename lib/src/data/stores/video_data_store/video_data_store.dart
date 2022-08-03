import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';

abstract class VideoDataStore {
  FutureOr<VideoDataModel> setVideo(VideoDataModel videoModel);

  FutureOr<VideoDataModel> getVideo(String videoId);

  FutureOr<void> deleteVideo(String videoId);

  FutureOr<List<VideoDataModel>> getVideos({
    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<VideoDataModel>> getVideosOfArtist(
    String artistId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<VideoDataModel>> getVideosOfDance(
    String danceId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<VideoDataModel>> getVideosOfFigure(
    String figureId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });
}
