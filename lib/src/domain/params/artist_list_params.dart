import 'package:dance/domain.dart';

abstract class ArtistListParams implements SearchListParams {
  final String? ofDanceId;
  final String? ofFigureId;
  final String? ofVideoId;

  ArtistListParams(
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,
  );
}
