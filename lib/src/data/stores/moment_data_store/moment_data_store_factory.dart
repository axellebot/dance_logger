import 'package:dance/data.dart';

class MomentDataStoreFactory {
  final MomentDataStore databaseDataStore;

  MomentDataStoreFactory({
    required this.databaseDataStore,
  });

  MomentDataStore get create => databaseDataStore;

  @override
  String toString() => '$runtimeType{'
      'databaseDataStore: $databaseDataStore, '
      '}';
}
