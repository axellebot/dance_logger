import 'package:flutter/material.dart';

abstract class EntityList extends StatelessWidget {
  final Axis scrollDirection;

  const EntityList({super.key, required this.scrollDirection});
}

class EmptyListView extends StatelessWidget {
  final Axis scrollDirection;
  final String label;

  const EmptyListView({
    super.key,
    this.scrollDirection = Axis.vertical,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: scrollDirection,
      children: [
        (scrollDirection == Axis.vertical)
            ? ListTile(title: Text(label))
            : Card(child: Text(label))
      ],
    );
  }
}

class SectionTile extends StatelessWidget {
  final Widget? leading;
  final GestureTapCallback? onTap;
  final Widget title;
  final Widget? trailing;

  const SectionTile({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      trailing: trailing,
      onTap: onTap,
    );
  }
}
