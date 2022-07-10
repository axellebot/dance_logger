import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final double? width;
  final double? height;

  const LoadingIndicator({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 24,
      width: width ?? 24,
      child: const CircularProgressIndicator(strokeWidth: 1.5),
    );
  }
}

class LoadingApp extends StatelessWidget {
  const LoadingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoadingPage(),
    );
  }
}

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const LoadingIndicator(),
            Text(DanceLocalizations.of(context)?.appName ?? 'Dance'),
          ],
        ),
      ),
    );
  }
}

class LoadingListView extends StatelessWidget {
  final Axis scrollDirection;

  const LoadingListView({
    super.key,
    this.scrollDirection = Axis.vertical,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: scrollDirection,
    );
  }
}

class LoadingTile extends StatelessWidget {
  const LoadingTile({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: LoadingIndicator(),
    );
  }
}

class BottomListLoadingIndicator extends StatelessWidget {
  const BottomListLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 75,
      child: Center(
        child: LoadingIndicator(),
      ),
    );
  }
}

class RightListLoadingIndicator extends StatelessWidget {
  const RightListLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 100,
      width: 150,
      child: Center(
        child: LoadingIndicator(),
      ),
    );
  }
}
