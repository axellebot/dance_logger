import 'package:dance/domain.dart';

abstract class DanceListParams implements SearchListParams {
  final String? ofArtist;
  final String? ofVideo;

  DanceListParams(this.ofArtist, this.ofVideo);
}
