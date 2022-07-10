import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: DatabaseFileSettingDialog(),
      ),
    );
  }
}
