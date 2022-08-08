import 'dart:async';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';

class ImplAppPrefsRepository extends AppPrefsRepository {
  final AppPrefsDataStoreFactory factory;

  ImplAppPrefsRepository({required this.factory});

  @override
  FutureOr<bool> saveThemeMode(int themeMode) {
    return factory.create.setThemeMode(themeMode);
  }

  @override
  FutureOr<int?> getThemeMode() {
    return factory.create.getThemeMode();
  }

  @override
  FutureOr<bool> deleteDarkMode() {
    return factory.create.deleteThemeMode();
  }

  @override
  FutureOr<bool> deleteThemeUltraDark() {
    return factory.create.deleteThemeUltraDark();
  }

  @override
  FutureOr<bool?> getThemeUltraDark() {
    return factory.create.getThemeUltraDark();
  }

  @override
  FutureOr<bool> saveThemeUltraDark(bool themeUltraDark) {
    return factory.create.setThemeUltraDark(themeUltraDark);
  }

  @override
  FutureOr<String?> getFileDir() {
    return factory.create.getFileDir();
  }

  @override
  FutureOr<bool> saveFileDir(String fileDir) {
    return factory.create.setFileDir(fileDir);
  }

  @override
  FutureOr<bool> deleteFileDir() {
    return factory.create.deleteFileDir();
  }

  @override
  FutureOr<String?> getFileName() {
    return factory.create.getFileName();
  }

  @override
  FutureOr<bool> saveFileName(String fileName) {
    return factory.create.setFileName(fileName);
  }

  @override
  FutureOr<bool> deleteFileName() {
    return factory.create.deleteFileName();
  }

  @override
  FutureOr<bool> deleteAll() {
    return factory.create.deleteAll();
  }
}
