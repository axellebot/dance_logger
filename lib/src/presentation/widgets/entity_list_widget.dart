import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class EmptyListView extends StatelessWidget {
  final Axis scrollDirection;
  final EdgeInsets? padding;
  final String label;

  const EmptyListView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.padding,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: scrollDirection,
      padding: padding,
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

class ItemTile extends ListTile {
  const ItemTile({
    super.key,
  });
}

class SectionTile extends StatelessWidget {
  final Widget? leading;
  final GestureTapCallback? onTap;
  final Widget title;
  final EdgeInsets? contentPadding;

  final Widget? trailing;

  const SectionTile({
    super.key,
    this.leading,
    required this.title,
    this.trailing,
    this.onTap,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: title,
      trailing: (trailing == null && onTap != null)
          ? const Icon(MdiIcons.arrowRight)
          : trailing,
      contentPadding: contentPadding,
      onTap: onTap,
    );
  }
}
