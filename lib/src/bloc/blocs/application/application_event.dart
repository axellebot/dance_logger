import 'package:equatable/equatable.dart';

/// [AppEvent] that must be dispatch to [AppBloc]
abstract class AppEvent extends Equatable {
  const AppEvent() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'AppEvent{}';
}

class AppLaunch extends AppEvent {}

class AppThemeChange extends AppEvent {
  final int themeMode;
  final bool themeUltraDark;

  const AppThemeChange({
    required this.themeMode,
    required this.themeUltraDark,
  }) : super();

  @override
  List<Object?> get props => [themeMode, themeUltraDark];

  @override
  String toString() => 'AppThemeChange{'
      'themeMode: $themeMode, '
      'ultraDark: $themeUltraDark'
      '}';
}
