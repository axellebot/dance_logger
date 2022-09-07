import 'package:dance/presentation.dart';
import 'package:uuid/uuid.dart';

class DanceViewModel extends BaseViewModel {
  String name;

  DanceViewModel({
    required super.id,
    required this.name,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory DanceViewModel.createNew({
    required String name,
  }) {
    return DanceViewModel(
      id: const Uuid().v4(),
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
    );
  }

  DanceViewModel copyWith({
    String? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return DanceViewModel(
      id: id ?? this.id,
      name: name ?? this.name,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
