import 'package:dance/domain.dart';
import 'package:flutter/material.dart';

class FigureListPage extends StatelessWidget {
  final String _tag = '$FigureListPage';

  FigureListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<FigureEntity> figures = [];
    return ListView.builder(
      itemCount: figures.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(figures[index].name),
      ),
    );
  }
}
