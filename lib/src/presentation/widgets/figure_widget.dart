import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class FigureItemTile extends StatelessWidget {
  final FigureViewModel figure;

  const FigureItemTile({
    super.key,
    required this.figure,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(figure.name),
      // onTap: () => AutoRouter.of(context).push(
      //   FigureDetailsRoute(figureId: figure.id),
      // ),
    );
  }
}

class FigureItemCard extends StatelessWidget {
  final FigureViewModel figure;

  const FigureItemCard({
    super.key,
    required this.figure,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppStyles.cardWidth,
      height: AppStyles.cardHeight,
      child: GestureDetector(
        // onTap: () => AutoRouter.of(context).push(
        //   FigureDetailsRoute(figureId: figure.id),
        // ),
        child: Card(
          elevation: AppStyles.cardElevation,
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
