import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:settings_ui/settings_ui.dart';

/// Wrap all global bloc to configure them
class ConfigWrapper extends StatelessWidget {
  const ConfigWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigurationBloc>(
      create: (_) => ConfigurationBloc()..add(ConfigLoad()),
      child: AppWrapper(),
    );
  }
}

class AppWrapper extends StatelessWidget {
  const AppWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, ConfigurationState state) {
        if (state is ConfigNotLoaded || state is ConfigLoaded) {
          late AppPrefsRepository appPrefsRepository;
          late List<Provider> providers;

          if (state is ConfigNotLoaded) {
            appPrefsRepository = state.appPrefsRepository;
            providers = <Provider>[
              RepositoryProvider<AppPrefsRepository>.value(
                value: appPrefsRepository,
              ),
            ];
          } else if (state is ConfigLoaded) {
            /// Dependency Injection of repositories
            /// Use updateShouldNotify to make dependencies available in
            /// `initState` methods of children widgets
            appPrefsRepository = state.appPrefsRepository;
            providers = <Provider>[
              RepositoryProvider<AppPrefsRepository>.value(
                value: appPrefsRepository,
              ),
              RepositoryProvider<ArtistRepository>.value(
                value: state.artistRepository,
              ),
              RepositoryProvider<FigureRepository>.value(
                value: state.figureRepository,
              ),
              RepositoryProvider<VideoRepository>.value(
                value: state.videoRepository,
              ),
              RepositoryProvider<PracticeRepository>.value(
                value: state.practiceRepository,
              ),
              RepositoryProvider<DanceRepository>.value(
                value: state.danceRepository,
              ),
            ];
          }
          return MultiProvider(
            providers: providers,
            child: BlocProvider<AppBloc>(
              create: (_) =>
                  AppBloc(appPreferencesRepository: appPrefsRepository)
                    ..add(AppLaunch()),
              child: App(),
            ),
          );
        } else if (state is ConfigLoading) {
          return const LoadingApp();
        }
        return ErrorApp(
          error: NotSupportedError(message: '${state.runtimeType}'),
        );
      },
    );
  }
}

class App extends StatelessWidget {
  App({
    super.key,
  });

  final appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    ///Routes

    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, AppState state) {
        if (state is AppUninitialized) {
          return const LoadingApp();
        } else if (state is AppInitialized) {
          ThemeMode themeMode;
          switch (state.themeMode) {
            case 0:
              themeMode = ThemeMode.system;
              break;
            case 1:
              themeMode = ThemeMode.light;
              break;
            case 2:
              themeMode = ThemeMode.dark;
              break;
            default:
              themeMode = ThemeMode.system;
          }
          return MaterialApp.router(
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
            onGenerateTitle: (BuildContext context) =>
                DanceLocalizations.of(context)?.appName ?? 'Dance',
            theme: _buildTheme(
              darkMode: false,
              ultraDark: state.themeUltraDark,
            ),
            darkTheme: _buildTheme(
              darkMode: true,
              ultraDark: state.themeUltraDark,
            ),
            themeMode: themeMode,
            localizationsDelegates: const [
              DanceLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('fr', ''),
            ],
            debugShowCheckedModeBanner: false,
          );
        }
        return ErrorApp(error: NotImplementedYetError('${state.runtimeType}'));
      },
    );
  }

  ThemeData _buildTheme({required bool darkMode, required bool ultraDark}) {
    ThemeData themeData;

    if (!darkMode) {
      themeData = ThemeData(
        brightness: Brightness.light,
        colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: AppStyles.primaryColorLight,
          onPrimary: AppStyles.onPrimaryColorLight,
          secondary: AppStyles.secondaryColorLight,
          onSecondary: AppStyles.onSecondaryColorLight,
          background: AppStyles.backgroundColorLight,
          onBackground: AppStyles.onBackgroundColorLight,
          surface: AppStyles.surfaceColorLight,
          onSurface: AppStyles.onSurfaceColorLight,
          error: AppStyles.errorColorLight,
          onError: AppStyles.onErrorColorLight,
        ),
      );
    } else {
      themeData = ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primary: ultraDark
              ? AppStyles.primaryColorDarkUltra
              : AppStyles.primaryColorDark,
          onPrimary: AppStyles.onPrimaryColorDark,
          secondary: ultraDark
              ? AppStyles.secondaryColorDarkUltra
              : AppStyles.secondaryColorDark,
          onSecondary: AppStyles.onSecondaryColorDark,
          background: ultraDark
              ? AppStyles.backgroundColorDarkUltra
              : AppStyles.backgroundColorDark,
          onBackground: AppStyles.onBackgroundColorDark,
          surface: ultraDark
              ? AppStyles.surfaceColorDarkUltra
              : AppStyles.surfaceColorDark,
          onSurface: AppStyles.onSurfaceColorDark,
          error: ultraDark
              ? AppStyles.errorColorDarkUltra
              : AppStyles.errorColorDark,
          onError: AppStyles.onErrorColorDark,
        ),
      );
    }

    themeData = themeData.copyWith(
      inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
        border: const OutlineInputBorder(),
      ),
      bottomSheetTheme: themeData.bottomSheetTheme.copyWith(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppStyles.bottomSheetRadius),
          ),
        ),
      ),
      cardTheme: themeData.cardTheme.copyWith(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppStyles.cardBorderRadius),
          ),
        ),
      ),
      navigationBarTheme: themeData.navigationBarTheme.copyWith(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        // height: AppStyles.navigationBarHeight,
      ),
      navigationRailTheme: themeData.navigationRailTheme.copyWith(
        useIndicator: false,
      ),
    );

    // Theme more non migrate ColorScheme (https://github.com/flutter/flutter/issues/91772)

    return themeData.copyWith(
      dialogTheme: _buildDialogTheme(
        themeData,
        darkMode: darkMode,
        ultraDark: ultraDark,
      ),
      cardTheme: _buildCardTheme(
        themeData,
        darkMode: darkMode,
        ultraDark: ultraDark,
      ),
    );
  }

  CardTheme _buildCardTheme(
    ThemeData themeData, {
    required bool darkMode,
    required bool ultraDark,
  }) {
    return themeData.cardTheme.copyWith(
      surfaceTintColor: themeData.colorScheme.background,
    );
  }

  DialogTheme _buildDialogTheme(
    ThemeData themeData, {
    required bool darkMode,
    required bool ultraDark,
  }) {
    if (!darkMode) {
      return themeData.dialogTheme.copyWith(
        backgroundColor: themeData.colorScheme.background,
      );
    } else {
      return themeData.dialogTheme.copyWith(
        backgroundColor: themeData.colorScheme.background,
      );
    }
  }

  SettingsThemeData _buildSettingsTheme(BuildContext context) {
    final ThemeData appTheme = Theme.of(context);

    return SettingsThemeData(
      dividerColor: appTheme.dividerColor,
      settingsSectionBackground: appTheme.backgroundColor,
      settingsListBackground: appTheme.scaffoldBackgroundColor,
    );
  }
}
