import 'package:dance/data.dart';

class PracticeDataStoreFactory {
  final PracticeDataStore databaseDataStore;

  PracticeDataStoreFactory({
    required this.databaseDataStore,
  });

  PracticeDataStore get create => databaseDataStore;

  @override
  String toString() => '$runtimeType{ '
      'databaseDataStore: $databaseDataStore, '
      ' }';
}
