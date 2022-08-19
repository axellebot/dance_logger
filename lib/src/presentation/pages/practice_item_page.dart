import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  final String practiceId;

  const PracticeDetailsPage({
    super.key,
    required this.practiceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PracticeDetailBloc, PracticeDetailState>(
      builder: (BuildContext context, PracticeDetailState state) {
        switch (state.status) {
          case PracticeDetailStatus.loading:
            return const LoadingPage();
          case PracticeDetailStatus.success:
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    PracticeEditRoute(
                      practiceId: state.practice!.id,
                    ),
                  );
                },
                child: const Icon(Icons.edit),
              ),
              body: CustomScrollView(
                slivers: <Widget>[
                  SliverAppBar(
                    pinned: true,
                    snap: false,
                    floating: false,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                      stretchModes: const [
                        StretchMode.fadeTitle,
                        StretchMode.blurBackground,
                        StretchMode.zoomBackground,
                      ],
                      title: Text('${state.practice!.doneAt}'),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        _buildFigureTile(state.practice!.figureId),
                        EntityInfoListTile(
                          createdAt: state.practice!.createdAt,
                          updateAt: state.practice!.updatedAt,
                          version: state.practice!.version,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case PracticeDetailStatus.failure:
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
    return BlocProvider<PracticeDetailBloc>(
      create: (BuildContext context) {
        return PracticeDetailBloc(
          practiceRepository:
              RepositoryProvider.of<PracticeRepository>(context),
          mapper: ModelMapper(),
        )..add(PracticeDetailLoad(practiceId: practiceId));
      },
      child: this,
    );
  }

  Widget _buildFigureTile(String figureId) {
    return BlocProvider<FigureDetailBloc>(
      create: (context) => FigureDetailBloc(
        figureRepository: RepositoryProvider.of<FigureRepository>(context),
        mapper: ModelMapper(),
      )..add(FigureDetailLoad(figureId: figureId)),
      child: Builder(builder: (context) {
        return BlocBuilder<FigureDetailBloc, FigureDetailState>(
          builder: (context, state) {
            switch (state.status) {
              case FigureDetailStatus.success:
                return FigureListTile(figure: state.figure!);
              default:
                return ErrorTile(
                  error: NotImplementedYetError('${state.status}'),
                );
            }
          },
        );
      }),
    );
  }
}

class PracticeCreatePage extends PracticeEditPage {
  const PracticeCreatePage({super.key});
}

class PracticeEditPage extends StatelessWidget implements AutoRouteWrapper {
  final String? practiceId;

  const PracticeEditPage({
    super.key,
    this.practiceId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Practice Edit'),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      // TODO: Replace with EditBloc
      create: (_) => PracticeDetailBloc(
          practiceRepository:
              RepositoryProvider.of<PracticeRepository>(context),
          mapper: ModelMapper()),
      child: this,
    );
  }
}
