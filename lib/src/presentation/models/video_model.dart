import 'package:dance/presentation.dart';

class VideoViewModel extends BaseViewModel {
  String name;
  String url;

  late List<ArtistViewModel>? artists;
  late List<FigureViewModel>? figures;
  late List<TimeViewModel>? times;

  VideoViewModel({
    required super.id,
    required this.name,
    required this.url,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'url: $url, '
      'artists: $artists, '
      'figures: $figures, '
      'times: $times, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
