import 'package:dance/data.dart';

class TimeDataStoreFactory {
  final TimeDataStore databaseDataStore;

  TimeDataStoreFactory({
    required this.databaseDataStore,
  });

  TimeDataStore get create => databaseDataStore;

  @override
  String toString() => '$runtimeType{'
      'databaseDataStore: $databaseDataStore, '
      '}';
}
