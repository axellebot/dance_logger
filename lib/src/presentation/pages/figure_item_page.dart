import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FigureDetailsPage extends StatelessWidget implements AutoRouteWrapper {
  final String figureId;

  const FigureDetailsPage({
    super.key,
    required this.figureId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FigureDetailBloc, FigureDetailState>(
      builder: (BuildContext context, FigureDetailState state) {
        switch (state.status) {
          case FigureDetailStatus.initial:
          case FigureDetailStatus.loading:
            return const LoadingPage();
          case FigureDetailStatus.success:
            return Scaffold(
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    FigureEditRoute(
                      figureBloc: BlocProvider.of<FigureDetailBloc>(context),
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
                      title: Text(state.figure!.name),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      <Widget>[
                        ArtistsSection(
                          // label: 'Artists of ${state.figure!.name}',
                          ofFigure: state.figure!.id,
                        ),
                        VideosSection(
                          // label: 'Videos of ${state.figure!.name}',
                          ofFigure: state.figure!.id,
                        ),
                        PracticesSection(
                          // label: 'Practices of ${state.figure!.name}',
                          ofFigure: state.figure!.id,
                        ),
                        EntityInfoListTile(
                          createdAt: state.figure!.createdAt,
                          updateAt: state.figure!.updatedAt,
                          version: state.figure!.version,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          case FigureDetailStatus.failure:
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
    return BlocProvider<FigureDetailBloc>(
      create: (BuildContext context) {
        return FigureDetailBloc(
          figureRepository: RepositoryProvider.of<FigureRepository>(context),
          mapper: ModelMapper(),
        )..add(FigureDetailLoad(figureId: figureId));
      },
      child: this,
    );
  }
}

class FigureCreatePage extends StatelessWidget {
  const FigureCreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Figure Create'),
    );
  }
}

class FigureEditPage extends StatelessWidget implements AutoRouteWrapper {
  late final FigureDetailBloc? _figureBloc;
  late final String? _figureId;

  FigureEditPage({
    super.key,
    FigureDetailBloc? figureBloc,
    String? figureId,
  }) : assert(figureBloc != null || figureId != null) {
    _figureId = figureId;
    _figureBloc = figureBloc;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButton: const FloatingActionButton(
        onPressed: null,
        child: Icon(Icons.save),
      ),
      body: const Text('Figure Edit'),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    if (_figureId != null) {
      return BlocProvider(
        create: (_) => FigureDetailBloc(
            figureRepository: RepositoryProvider.of<FigureRepository>(context),
            mapper: ModelMapper()),
        child: this,
      );
    } else if (_figureBloc != null) {
      return BlocProvider<FigureDetailBloc>.value(
        value: _figureBloc!,
        child: this,
      );
    }
    return this;
  }
}
