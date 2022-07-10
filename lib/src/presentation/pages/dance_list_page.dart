import 'package:dance/domain.dart';
import 'package:flutter/material.dart';

class DanceListPage extends StatelessWidget {
  final String _tag = '$DanceListPage';

  DanceListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<DanceEntity> dances = [];
    return ListView.builder(
      itemCount: dances.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(dances[index].name),
      ),
    );
  }
}
