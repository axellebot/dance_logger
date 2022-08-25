import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FigureDetailsPage extends StatefulWidget implements AutoRouteWrapper {
  final String figureId;

  const FigureDetailsPage({
    super.key,
    required this.figureId,
  });

  @override
  State<FigureDetailsPage> createState() => _FigureDetailsPageState();

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

class _FigureDetailsPageState extends State<FigureDetailsPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<FigureDetailBloc, FigureDetailState>(
      listener: (context, state) {
        switch (state.status) {
          case FigureDetailStatus.refreshingSuccess:
            _refreshController.refreshCompleted();
            break;
          case FigureDetailStatus.refreshingFailure:
            _refreshController.refreshFailed();
            break;
          default:
        }
      },
      child: BlocBuilder<FigureDetailBloc, FigureDetailState>(
        builder: (BuildContext context, FigureDetailState state) {
          final FigureDetailBloc figureDetailBloc =
              BlocProvider.of<FigureDetailBloc>(context);
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: false,
                  stretch: true,
                  title: (state.figure != null)
                      ? Text(state.figure!.name)
                      : const Text('Figure detail'),
                ),
                SliverFillRemaining(
                  child: SmartRefresher(
                    controller: _refreshController,
                    enablePullDown: true,
                    onRefresh: () {
                      figureDetailBloc.add(const FigureDetailRefresh());
                    },
                    child: ListView(
                      children: <Widget>[
                        if (state.figure != null)
                          ArtistsSection(
                            // label: 'Artists of ${state.figure!.name}',
                            ofFigure: state.figure!.id,
                          ),
                        if (state.figure != null)
                          VideosSection(
                            // label: 'Videos of ${state.figure!.name}',
                            ofFigure: state.figure!.id,
                          ),
                        if (state.figure != null)
                          PracticesSection(
                            // label: 'Practices of ${state.figure!.name}',
                            ofFigure: state.figure!.id,
                          ),
                        if (state.figure != null)
                          EntityInfoListTile(
                            createdAt: state.figure!.createdAt,
                            updateAt: state.figure!.updatedAt,
                            version: state.figure!.version,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
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
