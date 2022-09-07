import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MomentCreatePage extends MomentEditPage {
  const MomentCreatePage({super.key});
}

class MomentEditPage extends StatelessWidget implements AutoRouteWrapper {
  final MomentEditBloc? momentEditBloc;
  final String? momentId;

  const MomentEditPage({
    super.key,
    this.momentEditBloc,
    this.momentId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Moment Edit'),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => MomentEditBloc(
        momentRepository: RepositoryProvider.of<MomentRepository>(context),
        mapper: ModelMapper(),
      )..add(MomentEditStart(momentId: momentId)),
      child: this,
    );
  }
}
