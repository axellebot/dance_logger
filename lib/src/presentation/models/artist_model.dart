import 'package:dance/presentation.dart';

class ArtistViewModel extends BaseViewModel {
  String name;
  String? imageUrl;
  List<VideoViewModel>? videos;
  List<FigureViewModel>? figures;

  ArtistViewModel({
    required super.id,
    required this.name,
    this.imageUrl,
    this.figures,
    this.videos,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'figures: $figures, '
      'videos: $videos, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
