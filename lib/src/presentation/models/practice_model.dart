import 'package:dance/presentation.dart';

class PracticeViewModel extends BaseViewModel {
  String status;

  PracticeViewModel({
    required super.id,
    required this.status,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'status: $status, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
