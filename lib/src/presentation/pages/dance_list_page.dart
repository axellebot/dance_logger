import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DanceListPage extends StatelessWidget implements DanceListWidgetParams {
  /// Page params
  final bool showAppBar;

  /// DanceListWidgetParams
  @override
  final DanceListBloc? danceListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofVideo;

  const DanceListPage({
    super.key,

    /// Page params
    this.showAppBar = true,

    /// DanceListWidgetParams
    this.danceListBloc,
    this.ofArtist,
    this.ofVideo,
  }) : assert(danceListBloc == null || (ofArtist == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return DanceListBlocProvider(
      danceListBloc: danceListBloc,
      ofArtist: ofArtist,
      ofVideo: ofVideo,
      child: BlocBuilder<DanceListBloc, DanceListState>(
        builder: (context, state) {
          final danceListBloc = BlocProvider.of<DanceListBloc>(context);
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
                ? const DanceAppBar(
                    title: Text('Dances'),
                  )
                : null;
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(DanceCreateRoute());
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
      ),
    );
  }
}
