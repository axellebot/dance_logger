import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DanceDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  final String danceId;

  const DanceDetailsPage({
    super.key,
    required this.danceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanceDetailBloc, DanceDetailState>(
      builder: (BuildContext context, DanceDetailState state) {
        switch (state.status) {
          case DanceDetailStatus.loading:
            return const LoadingPage();
          case DanceDetailStatus.detailSuccess:
            final DanceDetailBloc danceDetailBloc =
                BlocProvider.of<DanceDetailBloc>(context);
            return Scaffold(
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    title: Text(state.dance!.name),
                    actions: [
                      IconButton(
                        onPressed: () {
                          AutoRouter.of(context).push(
                            DanceEditRoute(
                              danceId: state.dance!.id,
                            ),
                          );
                        },
                        icon: const Icon(Icons.edit),
                      ),
                      DeleteIconButton(
                        onDeleted: () {
                          danceDetailBloc.add(const DanceDetailDelete());
                        },
                      )
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        ArtistsSection(ofDance: danceId),
                        FiguresSection(ofDance: danceId),
                        VideosSection(ofDance: danceId),
                        EntityInfoListTile(
                          createdAt: state.dance!.createdAt,
                          updateAt: state.dance!.updatedAt,
                          version: state.dance!.version,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case DanceDetailStatus.failure:
            return ErrorPage(error: state.error);
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
    return BlocProvider<DanceDetailBloc>(
      create: (BuildContext context) {
        return DanceDetailBloc(
          danceRepository: RepositoryProvider.of<DanceRepository>(context),
          mapper: ModelMapper(),
        )..add(DanceDetailLoad(danceId: danceId));
      },
      child: this,
    );
  }
}

class DanceCreatePage extends DanceEditPage {
  DanceCreatePage({super.key});
}

class DanceEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final String? _danceId;

  DanceEditPage({
    super.key,
    String? danceId,
  }) {
    _danceId = danceId;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanceEditBloc, DanceEditState>(
      builder: (context, DanceEditState state) {
        switch (state.status) {
          case DanceEditStatus.loading:
            return const LoadingPage();
          case DanceEditStatus.failure:
            return ErrorPage(error: state.error!);
          case DanceEditStatus.ready:
          case DanceEditStatus.editSuccess:
            final danceEditBloc = BlocProvider.of<DanceEditBloc>(context);
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  onPressed: () {
                    AutoRouter.of(context).pop();
                  },
                  icon: const Icon(Icons.close),
                ),
                title: Text(
                  state.initialDance != null ? "Edit dance" : "Create dance",
                ),
                actions: <Widget>[
                  SaveButton(
                    onSaved: () {
                      danceEditBloc.add(const DanceEditSubmit());
                    },
                  ),
                  if (state.initialDance != null)
                    DeleteIconButton(
                      onDeleted: () {
                        danceEditBloc.add(const DanceEditDelete());
                      },
                    ),
                ],
              ),
              body: SingleChildScrollView(
                child: Container(
                  padding: AppStyles.formPadding,
                  child: const DanceForm(),
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
      create: (_) => DanceEditBloc(
        danceRepository: RepositoryProvider.of<DanceRepository>(context),
        mapper: ModelMapper(),
      )..add(DanceEditStart(danceId: _danceId)),
      child: this,
    );
  }
}
