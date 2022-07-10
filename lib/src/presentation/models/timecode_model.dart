import 'package:dance/presentation.dart';

class TimeViewModel extends BaseViewModel {
  String startTime;
  String endTime;

  VideoViewModel? video;
  List<ArtistViewModel>? artist;
  FigureViewModel? figure;

  TimeViewModel({
    required super.id,
    required this.startTime,
    required this.endTime,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'video: $video, '
      'artist: $artist, '
      'figure: $figure, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
