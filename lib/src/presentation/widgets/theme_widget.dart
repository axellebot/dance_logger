import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class ThemeTile extends StatelessWidget {
  const ThemeTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (BuildContext context, AppState state) {
        switch (state.status) {
          case AppStatus.success:
            final int themeMode = state.themeMode;
            final bool themeUltraDark = state.themeUltraDark;

            return ListTile(
              leading: const Icon(MdiIcons.themeLightDark),
              title: Text(DanceLocalizations.of(context)!.settingsThemeModeCTA),
              trailing: Wrap(
                direction: Axis.horizontal,
                crossAxisAlignment: WrapCrossAlignment.center,
                spacing: 10,
                children: [
                  ToggleButtons(
                    onPressed: (int index) {
                      BlocProvider.of<AppBloc>(context).add(
                        AppThemeChange(
                          themeMode: index,
                          themeUltraDark: themeUltraDark,
                        ),
                      );
                    },
                    isSelected: <bool>[
                      themeMode == 0,
                      themeMode == 1,
                      themeMode == 2,
                    ],
                    children: [
                      Tooltip(
                        message:
                            DanceLocalizations.of(context)!.settingsThemeSystem,
                        child: const Icon(Icons.settings),
                      ),
                      Tooltip(
                        message:
                            DanceLocalizations.of(context)!.settingsThemeLight,
                        child: const Icon(Icons.light_mode),
                      ),
                      Tooltip(
                        message:
                            DanceLocalizations.of(context)!.settingsThemeDark,
                        child: const Icon(Icons.dark_mode),
                      ),
                    ],
                  ),
                  ToggleButtons(
                    onPressed: (_) {
                      BlocProvider.of<AppBloc>(context).add(
                        AppThemeChange(
                          themeMode: themeMode,
                          themeUltraDark: !themeUltraDark,
                        ),
                      );
                    },
                    isSelected: [
                      themeUltraDark == true,
                    ],
                    children: [
                      Tooltip(
                        message: DanceLocalizations.of(context)!
                            .settingsThemeDarkUltra,
                        child: const Icon(MdiIcons.batteryHeartVariant),
                      ),
                    ],
                  ),
                ],
              ),
            );
          case AppStatus.failure:
            return ErrorTile(error: state.error);
          default:
            return ErrorTile(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }
}
