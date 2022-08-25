import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class FigureListPage extends StatelessWidget
    implements EntityListPageParams, FigureListWidgetParams {
  /// EntityListPageParams
  @override
  final bool showAppBar;
  @override
  final String? titleText;

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
    this.titleText,

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
          PreferredSizeWidget? appBar;
          if (showAppBar) {
            if (state.selectedFigures.isEmpty) {
              appBar = SearchAppBar(
                title:
                    (titleText != null) ? Text(titleText ?? 'Figures') : null,
                hintText: (titleText == null) ? 'Search figures' : null,
              );
            } else {
              appBar = SelectionAppBar(
                count: state.selectedFigures.length,
                onCanceled: () {
                  figureListBloc.add(const FigureListUnselect());
                },
                onDeleted: () {
                  figureListBloc.add(const FigureListDelete());
                },
              );
            }
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(const FigureCreateRoute());
              },
              child: const Icon(MdiIcons.plus),
            ),
            body: FigureListView(
              figureListBloc: figureListBloc,
              scrollDirection: Axis.vertical,
            ),
          );
        },
      ),
    );
  }
}
