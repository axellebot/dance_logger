import 'package:dance/presentation.dart';

class MomentViewModel extends BaseViewModel {
  Duration startTime;
  Duration? endTime;

  VideoViewModel? video;
  List<ArtistViewModel>? artists;
  FigureViewModel? figure;

  MomentViewModel({
    required super.id,
    required this.startTime,
    this.endTime,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'video: $video, '
      'artist: $artists, '
      'figure: $figure, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
