import 'package:dance/presentation.dart';
import 'package:uuid/uuid.dart';

class DanceViewModel extends BaseViewModel {
  String name;

  List<FigureViewModel>? figures;

  DanceViewModel({
    required super.id,
    required this.name,
    this.figures,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory DanceViewModel.createNew({
    String name = '',
  }) {
    return DanceViewModel(
      id: const Uuid().v4(),
      name: name,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
    );
  }

  change({
    String? name,
  }) {
    if (name != null) {
      this.name = name;
    }
    updatedAt = DateTime.now();
    version++;
  }

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'name: $name, '
      'figures: $figures, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
