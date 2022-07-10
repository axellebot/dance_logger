import 'package:bloc/bloc.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';

/// Business Logic Component for Application behaviors
/// Can manage theme
class AppBloc extends Bloc<AppEvent, AppState> {
  final String _tag = '$AppBloc';

  final AppPrefsRepository appPreferencesRepository;

  AppBloc({
    required this.appPreferencesRepository,
  }) : super(AppUninitialized()) {
    on<AppThemeChange>((event, emit) async {
      try {
        await appPreferencesRepository.setThemeMode(event.themeMode);
        await appPreferencesRepository.setThemeUltraDark(event.themeUltraDark);
        emit(AppInitialized(
          themeMode: event.themeMode,
          themeUltraDark: event.themeUltraDark,
        ));
      } catch (error) {
        addError(error, StackTrace.current);
      }
    });

    on<AppLaunch>((event, emit) async {
      try {
        final int themeMode =
            await appPreferencesRepository.getThemeMode() ?? 0;
        final bool themeUltraDark =
            await appPreferencesRepository.getThemeUltraDark() ?? false;
        emit(AppInitialized(
          themeMode: themeMode,
          themeUltraDark: themeUltraDark,
        ));
      } catch (error) {
        addError(error, StackTrace.current);
      }
    });
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    if (error is AppError) {
      emit(AppFailed(error: error));
    }
    super.onError(error, stackTrace);
  }
}
