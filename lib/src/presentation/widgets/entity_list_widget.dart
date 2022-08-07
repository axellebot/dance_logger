import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

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
            : SizedBox(
                width: AppStyles.cardWidth,
                height: AppStyles.cardHeight,
                child: Card(
                  child: Container(
                    padding: AppStyles.cardPadding,
                    child: Center(
                      child: Text(label),
                    ),
                  ),
                ),
              )
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
      trailing: (trailing == null && onTap != null)
          ? const Icon(MdiIcons.arrowRight)
          : trailing,
      onTap: onTap,
    );
  }
}
