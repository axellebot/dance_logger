import 'dart:async';

import 'package:dance/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Application preferences manager implementation
/// providing [AppPrefsDataStore]
class AppPrefsManager implements AppPrefsDataStore {
  final String _keyAppThemeMode = 'APP_THEME_MODE';
  final String _keyAppThemeUltraDark = 'APP_THEME_ULTRA_DARK';
  final String _keyAppDatabaseFileDirPath = 'APP_DATABASE_FILE_DIR_PATH';
  final String _keyAppDatabaseFileName = 'APP_DATABASE_FILE_NAME';

  FutureOr<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  AppPrefsManager();

  /// --------------------------------------------------------------------------
  ///                                Theme Mode
  /// --------------------------------------------------------------------------

  @override
  FutureOr<bool> setThemeMode(int themeMode) async {
    final storage = await _prefs;
    return await storage.setInt(
      _keyAppThemeMode,
      themeMode,
    );
  }

  @override
  FutureOr<int?> getThemeMode() async {
    final storage = await _prefs;
    return storage.getInt(_keyAppThemeMode) ?? 0;
  }

  @override
  FutureOr<bool> deleteThemeMode() async {
    final storage = await _prefs;
    return storage.remove(_keyAppThemeMode);
  }

  @override
  FutureOr<bool> setThemeUltraDark(bool themeUltraDark) async {
    final storage = await _prefs;
    return await storage.setBool(
      _keyAppThemeUltraDark,
      themeUltraDark,
    );
  }

  @override
  FutureOr<bool?> getThemeUltraDark() async {
    final storage = await _prefs;
    return storage.getBool(_keyAppThemeUltraDark) ?? false;
  }

  @override
  FutureOr<bool> deleteThemeUltraDark() async {
    final storage = await _prefs;
    return storage.remove(_keyAppThemeUltraDark);
  }

  /// --------------------------------------------------------------------------
  ///                               Database File Path
  /// --------------------------------------------------------------------------

  @override
  FutureOr<bool> setFileDir(String fileDirPath) async {
    final storage = await _prefs;
    return storage.setString(
      _keyAppDatabaseFileDirPath,
      fileDirPath,
    );
  }

  @override
  FutureOr<String?> getFileDir() async {
    final storage = await _prefs;
    return Future.value(storage.getString(_keyAppDatabaseFileDirPath));
  }

  @override
  FutureOr<bool> deleteFileDir() async {
    final storage = await _prefs;
    return storage.remove(_keyAppDatabaseFileDirPath);
  }

  @override
  FutureOr<bool> setFileName(String filePath) async {
    final storage = await _prefs;
    return storage.setString(
      _keyAppDatabaseFileName,
      filePath,
    );
  }

  @override
  FutureOr<String?> getFileName() async {
    final storage = await _prefs;
    return Future.value(storage.getString(_keyAppDatabaseFileName));
  }

  @override
  FutureOr<bool> deleteFileName() async {
    final storage = await _prefs;
    return storage.remove(_keyAppDatabaseFileName);
  }

  /// --------------------------------------------------------------------------
  ///                                    All
  /// --------------------------------------------------------------------------

  @override
  Future<bool> deleteAll() async {
    final storage = await _prefs;
    storage.remove(_keyAppThemeMode);
    storage.remove(_keyAppDatabaseFileName);
    return Future.value(true);
  }
}
