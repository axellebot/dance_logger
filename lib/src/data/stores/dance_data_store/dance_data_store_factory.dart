import 'package:dance/data.dart';

class DanceDataStoreFactory {
  final DanceDataStore databaseDataStore;

  DanceDataStoreFactory({
    required this.databaseDataStore,
  });

  DanceDataStore get create => databaseDataStore;

  @override
  String toString() => '$runtimeType{ '
      'databaseDataStore: $databaseDataStore, '
      ' }';
}
