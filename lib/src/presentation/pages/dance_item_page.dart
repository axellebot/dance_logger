import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class DanceDetailsPage extends StatefulWidget implements AutoRouteWrapper {
  final String danceId;

  const DanceDetailsPage({
    super.key,
    required this.danceId,
  });

  @override
  State<DanceDetailsPage> createState() => _DanceDetailsPageState();

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

class _DanceDetailsPageState extends State<DanceDetailsPage> {
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DanceDetailBloc, DanceDetailState>(
      listener: (context, state) {
        switch (state.status) {
          case DanceDetailStatus.refreshingSuccess:
            _refreshController.refreshCompleted();
            break;
          case DanceDetailStatus.refreshingFailure:
            _refreshController.refreshFailed();
            break;
          default:
        }
      },
      child: BlocBuilder<DanceDetailBloc, DanceDetailState>(
        builder: (BuildContext context, DanceDetailState state) {
          final DanceDetailBloc danceDetailBloc =
              BlocProvider.of<DanceDetailBloc>(context);
          return Scaffold(
            body: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  pinned: true,
                  snap: false,
                  floating: false,
                  title: (state.dance != null)
                      ? Text(state.dance!.name)
                      : const Text('Dance detail'),
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
                SliverFillRemaining(
                  child: SmartRefresher(
                    controller: _refreshController,
                    onRefresh: () {
                      danceDetailBloc.add(const DanceDetailRefresh());
                    },
                    child: ListView(
                      children: <Widget>[
                        if (state.dance != null)
                          ArtistsSection(
                            // label: 'Artists of ${state.dance!.name}',
                            ofDance: state.dance!.id,
                          ),
                        if (state.dance != null)
                          FiguresSection(
                            // label: 'Figures of ${state.dance!.name}',
                            ofDance: state.dance!.id,
                          ),
                        if (state.dance != null)
                          VideosSection(
                            // label: 'Videos of ${state.dance!.name}',
                            ofDance: state.dance!.id,
                          ),
                        if (state.dance != null)
                          EntityInfoListTile(
                            createdAt: state.dance!.createdAt,
                            updateAt: state.dance!.updatedAt,
                            version: state.dance!.version,
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

class DanceCreatePage extends DanceEditPage {
  const DanceCreatePage({super.key});
}

class DanceEditPage extends StatelessWidget implements AutoRouteWrapper {
  final String? danceId;

  const DanceEditPage({
    super.key,
    this.danceId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DanceEditBloc, DanceEditState>(
      builder: (context, DanceEditState state) {
        switch (state.status) {
          case DanceEditStatus.initial:
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
      )..add(DanceEditStart(danceId: danceId)),
      child: this,
    );
  }
}
