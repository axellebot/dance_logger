import 'package:dance/domain.dart';

abstract class DanceListParams implements SearchListParams {
  final String? ofArtistId;
  final String? ofVideoId;

  DanceListParams(
    this.ofArtistId,
    this.ofVideoId,
  );
}
