import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

void navigateToSettings(BuildContext context) {
  AutoRouter.of(context).push(SettingsRoute());
}

void openQuickSettings(BuildContext context) {
  showModalBottomSheet(
    context: context,
    builder: (context) => const QuickSettingsBottomSheet(),
  );
}

void openFileSetting(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => const DatabaseFileSettingDialog(),
  );
}
