import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class FigureListTile extends StatelessWidget {
  final FigureViewModel figure;

  /// ListTile options
  final ItemCallback<FigureViewModel>? onTap;
  final ItemCallback<FigureViewModel>? onLongPress;
  final bool selected;

  const FigureListTile({
    super.key,
    required this.figure,

    /// ListTile options
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(figure.name),
      onTap: (onTap != null)
          ? () {
              onTap!(figure);
            }
          : () {
              AutoRouter.of(context).push(
                FigureDetailsRoute(figureId: figure.id),
              );
            },
      onLongPress: (onLongPress != null)
          ? () {
              onLongPress!(figure);
            }
          : null,
      selected: selected,
    );
  }
}

class CheckboxFigureListTile extends StatelessWidget {
  final FigureViewModel figure;

  /// CheckboxLitTile options
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxFigureListTile({
    super.key,
    required this.figure,

    /// CheckboxLitTile options
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(figure.name),
      value: value,
      onChanged: onChanged,
    );
  }
}

class FigureCard extends StatelessWidget {
  final FigureViewModel figure;

  const FigureCard({
    super.key,
    required this.figure,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppStyles.cardElevation,
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: AppStyles.cardWidth,
        height: AppStyles.cardHeight,
        child: InkWell(
          onTap: () {
            AutoRouter.of(context).push(
              FigureDetailsRoute(figureId: figure.id),
            );
          },
          child: Container(
            padding: AppStyles.cardPadding,
            child: Center(
              child: Text(figure.name),
            ),
          ),
        ),
      ),
    );
  }
}
