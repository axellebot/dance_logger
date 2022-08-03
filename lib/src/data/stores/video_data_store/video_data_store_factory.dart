import 'package:dance/data.dart';

class VideoDataStoreFactory {
  final VideoDataStore databaseDataStore;

  VideoDataStoreFactory({
    required this.databaseDataStore,
  });

  VideoDataStore get create => databaseDataStore;

  @override
  String toString() => '$runtimeType{'
      'databaseDataStore: $databaseDataStore, '
      '}';
}
