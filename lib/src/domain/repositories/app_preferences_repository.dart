import 'dart:async';

/// Repository interface for the application preferences
abstract class AppPrefsRepository {
  /// Get App dark mode
  ///
  /// Must return the application dark mode [int] or [null] if not found
  FutureOr<int?> getThemeMode();

  /// Set Application dark mode([int])
  FutureOr<bool> setThemeMode(int themeMode);

  /// Delete Application dark mode
  FutureOr<bool> deleteDarkMode();

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
  FutureOr<bool> setFileName(String fileName);

  /// Delete database file path
  FutureOr<bool> deleteFileName();

  /// Delete all application preferences
  FutureOr<bool> deleteAll();

  @override
  String toString() => '$runtimeType{}';
}
