import 'package:dance/presentation.dart';

class FigureViewModel extends BaseViewModel {
  String name;

  late List<ArtistViewModel>? artists;
  late List<TimeViewModel>? times;
  late List<VideoViewModel>? videos;
  late List<PracticeViewModel>? practices;

  FigureViewModel({
    required super.id,
    required this.name,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'artists: $artists, '
      'times: $times, '
      'videos: $videos, '
      'practices: $practices, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
