import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class DanceListTile extends StatelessWidget {
  final DanceViewModel dance;

  /// ListTile options
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool selected;

  const DanceListTile({
    super.key,
    required this.dance,

    /// ListTile options
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(dance.name),
      onTap: onTap ??
          () {
            AutoRouter.of(context).push(
              DanceDetailsRoute(danceId: dance.id),
            );
          },
      onLongPress: onLongPress,
      selected: selected,
    );
  }
}

class CheckboxDanceListTile extends StatelessWidget {
  final DanceViewModel dance;

  /// CheckboxLitTile options
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxDanceListTile({
    super.key,
    required this.dance,

    /// CheckboxLitTile options
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(dance.name),
      value: value,
      onChanged: onChanged,
    );
  }
}

class DanceChip extends StatelessWidget {
  final DanceViewModel dance;

  const DanceChip({
    super.key,
    required this.dance,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Chip(
        label: Text(dance.name),
      ),
    );
  }
}
