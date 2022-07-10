import 'dart:async';

abstract class AppPrefsDataStore {
  /// Get App dark mode
  ///
  /// Must return the application dark mode [int] or [null] if not found
  FutureOr<int?> getThemeMode();

  /// Set Application theme mode([int])
  FutureOr<bool> setThemeMode(int themeMode);

  /// Delete Application theme mode
  FutureOr<bool> deleteThemeMode();

  FutureOr<bool?> getThemeUltraDark();
  FutureOr<bool> setThemeUltraDark(bool themeUltraDark);
  FutureOr<bool> deleteThemeUltraDark();

  /// Get database file dir
  FutureOr<String?> getFileDir();

  /// Set database file dir
  FutureOr<bool> setFileDir(String fileDir);

  /// Delete database file dir
  FutureOr<bool> deleteFileDir();

  /// Get database file name
  FutureOr<String?> getFileName();

  /// Set database file name
  FutureOr<bool> setFileName(String filePath);

  /// Delete database file name
  FutureOr<bool> deleteFileName();

  /// Delete all application preferences
  FutureOr<bool> deleteAll();
}
