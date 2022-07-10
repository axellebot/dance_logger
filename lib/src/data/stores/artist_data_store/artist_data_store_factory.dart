import 'package:dance/data.dart';

class ArtistDataStoreFactory {
  final ArtistDataStore databaseDataStore;

  ArtistDataStoreFactory({
    required this.databaseDataStore,
  });

  ArtistDataStore get create => databaseDataStore;

  @override
  String toString() => '$runtimeType{ '
      'databaseDataStore: $databaseDataStore, '
      ' }';
}
