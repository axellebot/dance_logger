import 'package:equatable/equatable.dart';

enum AppStatus { initial, loading, success, failure }

class AppState extends Equatable {
  final AppStatus status;
  final int themeMode;
  final bool themeUltraDark;
  final Error? error;

  const AppState({
    this.status = AppStatus.initial,
    this.themeMode = 0,
    this.themeUltraDark = false,
    this.error,
  });

  @override
  List<Object?> get props => [status, themeMode, themeUltraDark, error];

  AppState copyWith({
    AppStatus? status,
    int? themeMode,
    bool? themeUltraDark,
    Error? error,
  }) {
    return AppState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
      themeUltraDark: themeUltraDark ?? this.themeUltraDark,
      error: error ?? this.error,
    );
  }

  @override
  String toString() => 'AppInitialized{'
      'status: $status, '
      'themeMode: $themeMode, '
      'ultraDark: $themeUltraDark, '
      'error: $error'
      '}';
}
