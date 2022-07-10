import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class PracticeListPage extends StatelessWidget {
  final String _tag = '$PracticeListPage';

  PracticeListPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<PracticeViewModel> practices = [];
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: practices.length,
      itemBuilder: (context, index) => ListTile(
        title: Text(practices[index].id),
        subtitle: Text(practices[index].status.toString()),
      ),
    );
  }
}
