import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:easy_refresh/easy_refresh.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PracticeDetailsPage extends StatefulWidget implements AutoRouteWrapper {
  final String practiceId;

  const PracticeDetailsPage({
    super.key,
    required this.practiceId,
  });

  @override
  State<PracticeDetailsPage> createState() => _PracticeDetailsPageState();

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
}

class _PracticeDetailsPageState extends State<PracticeDetailsPage> {
  final EasyRefreshController _refreshController = EasyRefreshController(
    controlFinishRefresh: true,
  );

  @override
  Widget build(BuildContext context) {
    return BlocListener<PracticeDetailBloc, PracticeDetailState>(
      listener: (context, state) {
        switch (state.status) {
          case PracticeDetailStatus.refreshingSuccess:
            _refreshController.finishRefresh(IndicatorResult.success);
            break;
          case PracticeDetailStatus.refreshingFailure:
            _refreshController.finishRefresh(IndicatorResult.fail);
            break;
          default:
        }
      },
      child: BlocBuilder<PracticeDetailBloc, PracticeDetailState>(
          builder: (BuildContext context, PracticeDetailState state) {
        final PracticeDetailBloc practiceDetailBloc =
            BlocProvider.of<PracticeDetailBloc>(context);
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
                  title: (state.practice != null)
                      ? Text('${state.practice!.doneAt}')
                      : const Text('Practice detail'),
                ),
              ),
              SliverFillRemaining(
                child: EasyRefresh(
                  controller: _refreshController,
                  onRefresh: () {
                    practiceDetailBloc.add(const PracticeDetailRefresh());
                  },
                  child: ListView(
                    children: <Widget>[
                      // TODO: Add figure detail
                      if (state.practice != null)
                        EntityInfoListTile(
                          createdAt: state.practice!.createdAt,
                          updateAt: state.practice!.updatedAt,
                          version: state.practice!.version,
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
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
    // TODO: Practice edit page
    // return BlocProvider(
    //   create: (_) => PracticeDetailBloc(
    //       practiceRepository:
    //           RepositoryProvider.of<PracticeRepository>(context),
    //       mapper: ModelMapper()),
    //   child: this,
    // );
    return this;
  }
}
