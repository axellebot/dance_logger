import 'package:dance/presentation.dart';
import 'package:quiver/core.dart';
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
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory ArtistViewModel.createNew({
    String name = '',
    String? imageUrl,
  }) {
    return ArtistViewModel(
      id: const Uuid().v4(),
      name: name,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
    );
  }

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'imageUrl: $imageUrl, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';

  ArtistViewModel copyWith({
    String? id,
    String? name,
    Optional<String>? imageUrl,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return ArtistViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      imageUrl: imageUrl?.orNull ?? this.imageUrl,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }
}
