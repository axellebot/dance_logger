import 'package:dance/domain.dart';

abstract class ArtistListParams implements SearchListParams {
  final String? ofDance;
  final String? ofFigure;
  final String? ofVideo;

  ArtistListParams(this.ofDance, this.ofFigure, this.ofVideo);
}
