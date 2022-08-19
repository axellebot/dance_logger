import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FigureListPage extends StatelessWidget implements FigureListWidgetParams {
  /// Page params
  final bool showAppBar;

  /// FigureListWidgetParams
  @override
  final FigureListBloc? figureListBloc;
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  const FigureListPage({
    super.key,

    /// Page params
    this.showAppBar = true,

    /// FigureListParams
    this.figureListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
  }) : assert(figureListBloc == null ||
            (ofArtist == null && ofDance == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return FigureListBlocProvider(
      figureListBloc: figureListBloc,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofVideo: ofVideo,
      child: BlocBuilder<FigureListBloc, FigureListState>(
        builder: (context, state) {
          final figureListBloc = BlocProvider.of<FigureListBloc>(context);
          final PreferredSizeWidget? appBar;
          if (state.selectedFigures.isNotEmpty) {
            appBar = SelectingAppBar(
              count: state.selectedFigures.length,
              onCanceled: () {
                figureListBloc.add(const FigureListUnselect());
              },
              onDeleted: () {
                figureListBloc.add(const FigureListDelete());
              },
            );
          } else {
            appBar = (showAppBar)
                ? const DanceAppBar(
                    title: Text('Figures'),
                  )
                : null;
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(const FigureCreateRoute());
              },
              child: const Icon(MdiIcons.plus),
            ),
            body: RefreshIndicator(
              onRefresh: () {
                figureListBloc.add(const FigureListRefresh());
                return figureListBloc.stream
                    .firstWhere((e) => e.status != FigureListStatus.refreshing);
              },
              child: FigureListView(
                figureListBloc: figureListBloc,
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
