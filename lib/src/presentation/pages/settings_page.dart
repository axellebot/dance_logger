import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

@RoutePage()
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.settingsTitle ?? 'Settings'),
      ),
      body: const SafeArea(
        left: false,
        right: false,
        child: SettingsList(
          sections: [
            SettingsSection(
              title: Text('Appearance'),
              tiles: [
                CustomSettingsTile(
                  child: ThemeTile(),
                ),
              ],
            ),
            SettingsSection(
              title: Text('Database'),
              tiles: [
                CustomSettingsTile(
                  child: DatabaseFileSetupTile(),
                ),
                CustomSettingsTile(
                  child: DatabaseFileExportTile(),
                ),
              ],
            ),
            SettingsSection(
              title: Text('Other'),
              tiles: [
                CustomSettingsTile(
                  child: AboutListTile(
                    icon: Icon(Icons.info),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
