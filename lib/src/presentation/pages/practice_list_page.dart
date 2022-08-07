import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class PracticeListPage extends StatelessWidget implements AutoRouteWrapper {
  final String? ofFigure;
  final PracticeListBloc? practiceListBloc;

  const PracticeListPage({
    super.key,
    this.ofFigure,
    this.practiceListBloc,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Practices'),
      ),
      body: const PracticeListView(),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final repo = Provider.of<PracticeRepository>(context, listen: false);
    if (practiceListBloc != null) {
      return BlocProvider<PracticeListBloc>.value(
        value: practiceListBloc!,
        child: this,
      );
    } else {
      return BlocProvider<PracticeListBloc>(
        create: (_) => PracticeListBloc(
          practiceRepository: repo,
          mapper: ModelMapper(),
        )..add(PracticeListLoad(
            ofFigure: ofFigure,
          )),
        child: this,
      );
    }
  }
}
