abstract class BaseEntity {
  late String id;
  late DateTime createdAt;
  late DateTime updatedAt;
  late int version;

  @override
  String toString() => '$runtimeType{ '
      'id: $id, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      ' }';
}
