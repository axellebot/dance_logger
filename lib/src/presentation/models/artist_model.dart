import 'package:dance/presentation.dart';
import 'package:uuid/uuid.dart';

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

  factory ArtistViewModel.createNew({
    String name = '',
  }) {
    return ArtistViewModel(
      id: const Uuid().v4(),
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
    );
  }

  change({
    String? name,
    String? imageUrl,
  }) {
    if (name != null) this.name = name;
    if (imageUrl != null) this.imageUrl = imageUrl;
    updatedAt = DateTime.now();
    version++;
  }

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'imageUrl: $imageUrl, '
      'figures: $figures, '
      'videos: $videos, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
