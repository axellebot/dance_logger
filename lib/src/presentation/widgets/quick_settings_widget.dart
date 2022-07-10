import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class QuickSettingsExtendableButton extends StatelessWidget {
  const QuickSettingsExtendableButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Animation<double> animation =
        NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return animation.value == 0
            ? QuickSettingsActionButton()
            : Row(
                children: [
                  TextButton.icon(
                    icon: const Icon(Icons.more_horiz),
                    label: const Text('Quick Settings'),
                    onPressed: () => openQuickSettings(context),
                  ),
                ],
              );
      },
    );
  }
}

class QuickSettingsActionButton extends StatelessWidget {
  final String _tag = '$QuickSettingsActionButton';
  final EdgeInsetsGeometry padding;

  QuickSettingsActionButton({
    super.key,
    this.padding = const EdgeInsets.symmetric(
      vertical: AppStyles.menuButtonVerticalPadding,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: IconButton(
        onPressed: () => openQuickSettings(context),
        icon: Icon(MediaQuery.of(context).orientation == Orientation.portrait
            ? Icons.more_vert_rounded
            : Icons.more_horiz_rounded),
      ),
    );
  }
}

class QuickSettingsBottomSheet extends StatelessWidget {
  final String _tag = '$QuickSettingsBottomSheet';

  QuickSettingsBottomSheet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      right: false,
      child: Wrap(
        children: <Widget>[
          const ThemeTile(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text(DanceLocalizations.of(context)!.settingsCTA),
            onTap: () => navigateToSettings(context),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: null,
                child: Text(DanceLocalizations.of(context)!.menuPPCTA),
              ),
              const Text('·'),
              MaterialButton(
                onPressed: null,
                child: Text(DanceLocalizations.of(context)!.menuToSCTA),
              ),
            ],
          )
        ],
      ),
    );
  }
}
