import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

/// Wrap all global bloc to configure them
class ConfigWrapper extends StatelessWidget {
  const ConfigWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ConfigurationBloc>(
      create: (_) => ConfigurationBloc()..add(ConfigLoad()),
      child: const RepoWrapper(),
    );
  }
}

class RepoWrapper extends StatelessWidget {
  const RepoWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigState>(
      builder: (context, ConfigState state) {
        switch (state.status) {
          case ConfigStatus.ready:

            /// Display normal app
            late List<Provider> providers;

            /// Dependency Injection of repositories
            /// Use updateShouldNotify to make dependencies available in
            /// `initState` methods of children widgets
            final AppPrefsRepository appPrefsRepository = state.appPrefsRepository!;
            providers = <Provider>[
              RepositoryProvider<AppPrefsRepository>.value(
                value: appPrefsRepository,
              ),
              RepositoryProvider<ArtistRepository>.value(
                value: state.artistRepository!,
              ),
              RepositoryProvider<DanceRepository>.value(
                value: state.danceRepository!,
              ),
              RepositoryProvider<FigureRepository>.value(
                value: state.figureRepository!,
              ),
              RepositoryProvider<MomentRepository>.value(
                value: state.momentRepository!,
              ),
              RepositoryProvider<PracticeRepository>.value(
                value: state.practiceRepository!,
              ),
              RepositoryProvider<VideoRepository>.value(
                value: state.videoRepository!,
              ),
            ];
            return MultiProvider(
              providers: providers,
              child: BlocProvider<AppBloc>(
                create: (_) => AppBloc(appPreferencesRepository: appPrefsRepository)..add(AppLaunch()),
                child: App(),
              ),
            );
          case ConfigStatus.initial:
          case ConfigStatus.loading:
            return const LoadingApp();
          case ConfigStatus.failure:
            return ErrorApp(
              error: state.error,
            );
          default:
            return ErrorApp(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
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
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, AppState state) {
        switch (state.status) {
          case AppStatus.initial:
          case AppStatus.loading:
            return const LoadingApp();
          case AppStatus.success:
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
              scrollBehavior: MyCustomScrollBehavior(),
              routerConfig: appRouter.config(),
              onGenerateTitle: (BuildContext context) => AppLocalizations.of(context)?.appName ?? 'Dance',
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
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('en', ''),
                Locale('fr', ''),
              ],
              debugShowCheckedModeBanner: false,
            );
          default:
            return ErrorApp(
              error: NotImplementedYetError('${state.status}'),
            );
        }
      },
    );
  }

  ThemeData _buildTheme({required bool darkMode, required bool ultraDark}) {
    ThemeData themeData;

    themeData = ThemeData(
      brightness: darkMode ? Brightness.dark : Brightness.light,
      useMaterial3: true,
      colorSchemeSeed: AppStyles.appColor,
    );

    themeData = themeData.copyWith(
      navigationBarTheme: themeData.navigationBarTheme.copyWith(
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
      navigationRailTheme: themeData.navigationRailTheme.copyWith(
        useIndicator: false,
      ),
    );

    // Theme more non migrate ColorScheme (https://github.com/flutter/flutter/issues/91772)

    return themeData = themeData.copyWith(
      inputDecorationTheme: themeData.inputDecorationTheme.copyWith(
        border: const OutlineInputBorder(),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
    );
  }
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}
