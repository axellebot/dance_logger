abstract class BaseViewModel {
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int version;

  BaseViewModel({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  }) : super();

  incrementVersion() {
    updatedAt = DateTime.now();
    version++;
  }

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
