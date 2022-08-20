import 'package:dance/domain.dart';

abstract class VideoListParams implements SearchListParams {
  final String? ofArtist;
  final String? ofDance;
  final String? ofFigure;

  VideoListParams(this.ofArtist, this.ofDance, this.ofFigure);
}
