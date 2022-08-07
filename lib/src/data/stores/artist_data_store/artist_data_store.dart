import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';

abstract class ArtistDataStore {
  FutureOr<ArtistDataModel> setArtist(ArtistDataModel artistModel);

  FutureOr<ArtistDataModel> getArtist(String artistId);

  FutureOr<void> deleteArtist(String artistId);

  FutureOr<List<ArtistDataModel>> getArtists({
    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<ArtistDataModel>> getArtistsOfDance(
    String danceId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<ArtistDataModel>> getArtistsOfVideo(
    String videoId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<ArtistDataModel>> getArtistsOfMoment(
    String timeId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });

  FutureOr<List<ArtistDataModel>> getArtistsOfFigure(
    String figureId, {

    /// TODO: Add filters
    /// TODO: Add sort
    required Offset offset,
  });
}
