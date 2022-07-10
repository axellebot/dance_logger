import 'package:equatable/equatable.dart';

abstract class AppState extends Equatable {
  const AppState() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'AppState{}';
}

class AppUninitialized extends AppState {}

class AppInitialized extends AppState {
  final int themeMode;
  final bool themeUltraDark;

  const AppInitialized({
    this.themeMode = 0,
    this.themeUltraDark = false,
  });

  @override
  List<Object?> get props => [themeMode, themeUltraDark];

  @override
  String toString() => 'AppInitialized{'
      'themeMode: $themeMode, '
      'ultraDark: $themeUltraDark'
      '}';
}

class AppFailed extends AppState {
  final Error error;

  const AppFailed({required this.error});

  @override
  List<Object?> get props => [error];

  @override
  String toString() => 'AppFailed{'
      'error: $error'
      '}';
}
