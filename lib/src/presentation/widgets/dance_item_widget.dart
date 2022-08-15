import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class DanceForm extends StatelessWidget {
  const DanceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final DanceEditBloc danceEditBloc = BlocProvider.of<DanceEditBloc>(context);
    return BlocBuilder<DanceEditBloc, DanceEditState>(
      builder: (BuildContext context, DanceEditState state) {
        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                initialValue: state.initialDance?.name,
                onChanged: (danceName) {
                  danceEditBloc.add(DanceEditChangeName(danceName: danceName));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
