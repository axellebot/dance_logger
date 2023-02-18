import 'package:dance/domain.dart';

abstract class VideoListParams implements SearchListParams {
  final String? ofArtistId;
  final String? ofDanceId;
  final String? ofFigureId;

  VideoListParams(
    this.ofArtistId,
    this.ofDanceId,
    this.ofFigureId,
  );
}
