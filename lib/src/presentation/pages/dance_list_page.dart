import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class DanceListPage extends StatelessWidget
    implements AutoRouteWrapper, DanceListParams {
  /// Page params
  final bool showAppBar;

  /// ListBloc params
  final DanceListBloc? danceListBloc;

  /// DanceListParams
  @override
  final String? ofArtist;
  @override
  final String? ofVideo;

  const DanceListPage({
    super.key,

    /// Page params
    this.showAppBar = true,

    /// ListBloc params
    this.danceListBloc,

    /// DanceListParams
    this.ofArtist,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    final danceListBloc = BlocProvider.of<DanceListBloc>(context);

    return BlocBuilder<DanceListBloc, DanceListState>(
      builder: (context, state) {
        final PreferredSizeWidget? appBar;
        if (state.selectedDances.isNotEmpty) {
          appBar = SelectingAppBar(
            count: state.selectedDances.length,
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
            child: DanceListView(
              danceListBloc: danceListBloc,
              scrollDirection: Axis.vertical,
              physics: const AlwaysScrollableScrollPhysics(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return (danceListBloc != null)
        ? BlocProvider<DanceListBloc>.value(
            value: danceListBloc!,
            child: this,
          )
        : BlocProvider<DanceListBloc>(
            create: (_) => DanceListBloc(
              danceRepository:
                  Provider.of<DanceRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(DanceListLoad(
                ofArtist: ofArtist,
                ofVideo: ofVideo,
              )),
            child: this,
          );
  }
}
