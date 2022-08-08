import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/src/bloc/bloc.dart';

/// Business Logic Component for Application behaviors
/// Can manage theme
class AppBloc extends Bloc<AppEvent, AppState> {
  final AppPrefsRepository appPreferencesRepository;

  AppBloc({
    required this.appPreferencesRepository,
  }) : super(const AppState()) {
    on<AppLaunch>(_onAppLaunch);
    on<AppThemeChange>(_onThemeChange);
  }

  FutureOr<void> _onAppLaunch(event, emit) async {
    try {
      final int themeMode = await appPreferencesRepository.getThemeMode() ?? 0;
      final bool themeUltraDark =
          await appPreferencesRepository.getThemeUltraDark() ?? false;
      emit(state.copyWith(
        status: AppStatus.success,
        themeMode: themeMode,
        themeUltraDark: themeUltraDark,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: AppStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onThemeChange(event, emit) async {
    try {
      await appPreferencesRepository.saveThemeMode(event.themeMode);
      await appPreferencesRepository.saveThemeUltraDark(event.themeUltraDark);
      emit(state.copyWith(
        status: AppStatus.success,
        themeMode: event.themeMode,
        themeUltraDark: event.themeUltraDark,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: AppStatus.failure,
        error: error,
      ));
    }
  }
}
