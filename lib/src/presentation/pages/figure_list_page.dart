import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@RoutePage<List<FigureViewModel>>()
class FigureListPage extends StatelessWidget
    implements EntityListPageParams, FigureListBlocParams {
  /// EntityListPageParams
  @override
  final bool showAppBar;
  @override
  final String? titleText;
  @override
  final bool shouldSelectOne;
  @override
  final bool shouldSelectMultiple;
  @override
  final List<FigureViewModel>? preselectedItems;

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

    /// EntityListPageParams
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,

    /// FigureListParams
    this.figureListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
  })  : assert(shouldSelectOne == false || shouldSelectMultiple == false),
        assert(figureListBloc == null ||
            (ofArtist == null && ofDance == null && ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return FigureListBlocProvider(
      figureListBloc: figureListBloc,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofVideo: ofVideo,
      preselectedFigures: preselectedItems,
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
                onDeleted: (state.selectedFigures.isNotEmpty)
                    ? () {
                        figureListBloc.add(const FigureListDelete());
                      }
                    : null,
                onConfirmed: (state.selectedFigures.isNotEmpty &&
                        shouldSelectMultiple)
                    ? () {
                        AutoRouter.of(context)
                            .pop<List<FigureViewModel>>(state.selectedFigures);
                      }
                    : null,
              );
            }
          }

          ItemCallback<FigureViewModel>? onSelect;

          if (shouldSelectOne) {
            onSelect = (item) {
              AutoRouter.of(context).pop<List<FigureViewModel>>([item]);
            };
          } else if (shouldSelectMultiple) {
            onSelect = (item) {
              figureListBloc.add(FigureListSelect(figures: [item]));
            };
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(const FigureCreateRoute());
              },
              child: Icon(MdiIcons.plus),
            ),
            body: FigureListView(
              onSelect: onSelect,
              figureListBloc: figureListBloc,
              scrollDirection: Axis.vertical,
            ),
          );
        },
      ),
    );
  }
}
