import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class MomentListTile extends StatelessWidget {
  final MomentViewModel moment;

  /// ListTile options
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool selected;

  const MomentListTile({
    super.key,
    required this.moment,

    /// ListTile options
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${moment.startTime}-${moment.endTime}'),
      onTap: onTap,
      onLongPress: onLongPress,
      selected: selected,
    );
  }
}

class CheckboxMomentListTile extends StatelessWidget {
  final MomentViewModel moment;

  /// CheckboxLitTile options
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxMomentListTile({
    super.key,
    required this.moment,

    /// CheckboxLitTile options
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('${moment.startTime}-${moment.endTime}'),
      value: value,
      onChanged: onChanged,
    );
  }
}

class MomentChip extends StatelessWidget {
  final MomentViewModel moment;

  const MomentChip({
    super.key,
    required this.moment,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Chip(
        label: (moment.endTime != null)
            ? Text(
                '${printDuration(moment.startTime)}-${printDuration(moment.endTime!)}')
            : Text(printDuration(moment.startTime)),
      ),
    );
  }
}
