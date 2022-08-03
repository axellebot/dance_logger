import 'package:dance/presentation.dart';

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
