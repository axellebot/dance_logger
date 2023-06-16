import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

/// Interface to implements basic `ListView` widget parameters
abstract class EntityListViewParams {
  /// EntityListViewParams
  final Axis scrollDirection;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  EntityListViewParams(this.scrollDirection, this.physics, this.padding);
}

/// Interface to implements basic Section widget parameters
abstract class EntitiesSectionWidgetParams {
  final String? label;
  final VoidCallback? onSectionTap;

  EntitiesSectionWidgetParams(this.label, this.onSectionTap);
}

class EmptyListView extends StatelessWidget implements EntityListViewParams {
  /// TODO: Remove all EmptyListView ?

  final String label;

  /// EntityListViewParams
  @override
  final Axis scrollDirection;
  @override
  final ScrollPhysics? physics;
  @override
  final EdgeInsetsGeometry? padding;

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
          ? Icon(MdiIcons.arrowRight)
          : trailing,
      contentPadding: contentPadding,
      onTap: onTap,
    );
  }
}
