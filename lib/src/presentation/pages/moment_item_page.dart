import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MomentCreatePage extends MomentEditPage {
  const MomentCreatePage({super.key});
}

@RoutePage()
class MomentEditPage extends StatelessWidget implements AutoRouteWrapper {
  final String? momentId;

  const MomentEditPage({
    super.key,
    @pathParam this.momentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MomentEditBloc, MomentEditState>(
      builder: (context, state) {
        switch (state.status) {
          case MomentEditStatus.initial:
          case MomentEditStatus.loading:
            return const LoadingPage();
          case MomentEditStatus.failure:
            return ErrorPage(error: state.error!);
          case MomentEditStatus.ready:
          case MomentEditStatus.editSuccess:
            final momentEditBloc = BlocProvider.of<MomentEditBloc>(context);
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
                title: Text(
                  state.initialMoment != null ? "Edit dance" : "Create dance",
                ),
                actions: <Widget>[
                  SaveButton(
                    onSaved: () {
                      momentEditBloc.add(const MomentEditSubmit());
                    },
                  ),
                  if (state.initialMoment != null)
                    DeleteIconButton(
                      onDeleted: () {
                        momentEditBloc.add(const MomentEditDelete());
                      },
                    ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: AppStyles.formPadding,
                  child: const MomentForm(),
                ),
              ),
            );
          default:
            return ErrorPage(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
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
