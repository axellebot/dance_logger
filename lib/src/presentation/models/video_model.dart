import 'package:dance/presentation.dart';
import 'package:uuid/uuid.dart';

class VideoViewModel extends BaseViewModel {
  String name;
  String url;

  VideoViewModel({
    required super.id,
    required this.name,
    required this.url,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory VideoViewModel.createNew({
    String name = '',
    String url = '',
  }) {
    return VideoViewModel(
      id: const Uuid().v4(),
      name: name,
      url: url,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
    );
  }

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'url: $url, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';

  VideoViewModel copyWith({
    String? id,
    String? name,
    String? url,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return VideoViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }
}
