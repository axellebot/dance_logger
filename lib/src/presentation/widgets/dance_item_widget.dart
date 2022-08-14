import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class DanceItemTile extends StatelessWidget {
  final DanceViewModel dance;

  const DanceItemTile({
    super.key,
    required this.dance,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(dance.name),
      onTap: () {
        AutoRouter.of(context).push(
          DanceDetailsRoute(danceId: dance.id),
        );
      },
    );
  }
}

class DanceItemChip extends StatelessWidget {
  final DanceViewModel dance;

  const DanceItemChip({
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
