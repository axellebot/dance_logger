import 'package:dance/presentation.dart';

class PracticeViewModel extends BaseViewModel {
  String status;
  DateTime doneAt;
  String figureId;

  PracticeViewModel({
    required super.id,
    required this.doneAt,
    required this.status,
    required this.figureId,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'doneAt: $doneAt, '
      'status: $status, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
