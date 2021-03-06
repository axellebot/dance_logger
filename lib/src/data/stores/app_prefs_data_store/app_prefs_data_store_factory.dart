import 'package:dance/data.dart';

class AppPrefsDataStoreFactory {
  final String _tag = '$AppPrefsDataStoreFactory';

  final AppPrefsDataStore diskDataStore;

  AppPrefsDataStore get create => diskDataStore;

  AppPrefsDataStoreFactory({required this.diskDataStore});

  @override
  String toString() => '$runtimeType{ '
      'diskDataStore: $diskDataStore'
      ' }';
}
