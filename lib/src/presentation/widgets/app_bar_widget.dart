import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class DanceAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget? title;

  const DanceAppBar({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: title,
      actions: <Widget>[
        if (MediaQuery.of(context).orientation == Orientation.portrait)
          const QuickSettingsActionButton()
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
