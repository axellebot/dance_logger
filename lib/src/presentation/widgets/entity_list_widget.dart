import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class SelectingAppBar extends StatelessWidget with PreferredSizeWidget {
  final int count;
  final VoidCallback? onCanceled;
  final VoidCallback? onDeleted;

  const SelectingAppBar({
    super.key,
    required this.count,
    this.onCanceled,
    this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onCanceled,
      ),
      title: Text('$count selected'),
      actions: [
        if (onDeleted != null)
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return DeleteDialog(
                    onConfirmed: onDeleted,
                  );
                },
              );
            },
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class EmptyListView extends StatelessWidget {
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;
  final String label;

  const EmptyListView({
    super.key,
    this.scrollDirection = Axis.vertical,
    this.physics,
    this.padding,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: scrollDirection,
      physics: physics,
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
