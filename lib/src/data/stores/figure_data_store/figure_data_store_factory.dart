import 'package:dance/data.dart';

class FigureDataStoreFactory {
  final FigureDataStore databaseDataStore;

  FigureDataStoreFactory({
    required this.databaseDataStore,
  });

  FigureDataStore get create => databaseDataStore;

  @override
  String toString() => '$runtimeType{'
      'databaseDataStore: $databaseDataStore, '
      '}';
}
