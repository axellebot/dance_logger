import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DanceListPage extends StatelessWidget implements AutoRouteWrapper {
  final bool showAppBar;
  final String? ofArtist;
  final String? ofFigure;
  final String? ofVideo;
  final DanceListBloc? danceListBloc;

  const DanceListPage({
    super.key,
    this.showAppBar = true,
    this.ofArtist,
    this.ofFigure,
    this.ofVideo,
    this.danceListBloc,
  });

  @override
  Widget build(BuildContext context) {
    final danceListBloc = BlocProvider.of<DanceListBloc>(context);

    return BlocBuilder<DanceListBloc, DanceListState>(
      builder: (context, state) {
        final PreferredSizeWidget? appBar;
        if (state.selected.isNotEmpty) {
          appBar = SelectingAppBar(
            count: state.selected.length,
            onCanceled: () {
              danceListBloc.add(const DanceListUnselect());
            },
            onDeleted: () {
              danceListBloc.add(const DanceListDelete());
            },
          );
        } else {
          appBar = (showAppBar)
              ? AppBar(
                  title: const Text('Dances'),
                )
              : null;
        }

        return Scaffold(
          appBar: appBar,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(DanceEditRoute());
            },
            child: const Icon(MdiIcons.plus),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              danceListBloc.add(const DanceListRefresh());
              return danceListBloc.stream
                  .firstWhere((e) => e.status != DanceListStatus.refreshing);
            },
            child: const DanceListView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final repo = Provider.of<DanceRepository>(context, listen: false);
    if (danceListBloc != null) {
      return BlocProvider<DanceListBloc>.value(
        value: danceListBloc!,
        child: this,
      );
    } else {
      return BlocProvider<DanceListBloc>(
        create: (_) => DanceListBloc(
          danceRepository: repo,
          mapper: ModelMapper(),
        )..add(DanceListLoad(
            ofArtist: ofArtist,
            ofFigure: ofFigure,
            ofVideo: ofVideo,
          )),
        child: this,
      );
    }
  }
}
