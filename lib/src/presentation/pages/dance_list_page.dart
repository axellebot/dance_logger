import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@RoutePage<List<DanceViewModel>>()
class DanceListPage extends StatelessWidget
    implements EntityListPageParams<DanceViewModel>, DanceListWidgetParams {
  /// EntityListPageParams
  @override
  final bool showAppBar;
  @override
  final String? titleText;
  @override
  final bool shouldSelectOne;
  @override
  final bool shouldSelectMultiple;

  /// DanceListWidgetParams
  @override
  final String? ofSearch;
  @override
  final DanceListBloc? danceListBloc;
  @override
  final String? ofArtistId;
  @override
  final String? ofVideoId;
  @override
  final List<DanceViewModel>? preselectedItems;

  const DanceListPage({
    super.key,

    /// Page params
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,

    /// DanceListWidgetParams
    this.danceListBloc,
    this.ofSearch,
    this.ofArtistId,
    this.ofVideoId,
  })  : assert(shouldSelectOne == false || shouldSelectMultiple == false),
        assert(danceListBloc == null ||
            ofSearch == null ||
            (ofArtistId == null && ofVideoId == null));

  @override
  Widget build(BuildContext context) {
    return DanceListBlocProvider(
      danceListBloc: danceListBloc,
      ofSearch: ofSearch,
      ofArtistId: ofArtistId,
      ofVideoId: ofVideoId,
      preselectedDances: preselectedItems,
      child: BlocBuilder<DanceListBloc, DanceListState>(
        builder: (context, state) {
          final danceListBloc = BlocProvider.of<DanceListBloc>(context);
          PreferredSizeWidget? appBar;
          if (showAppBar) {
            if (state.selectedDances.isEmpty) {
              appBar = SearchAppBar(
                title: (titleText != null) ? Text(titleText ?? 'Dances') : null,
                hintText: (titleText == null) ? 'Search dances' : null,
                onSearch: () {
                  showSearch(
                    context: context,
                    delegate: DancesSearchDelegate(
                      searchFieldLabel: 'Search dances',
                    ),
                  );
                },
              );
            } else {
              appBar = SelectionAppBar(
                count: state.selectedDances.length,
                onCanceled: () {
                  danceListBloc.add(const DanceListUnselect());
                },
                onDeleted: (state.selectedDances.isNotEmpty)
                    ? () {
                        danceListBloc.add(const DanceListDelete());
                      }
                    : null,
                onConfirmed: (state.selectedDances.isNotEmpty &&
                        shouldSelectMultiple)
                    ? () {
                        AutoRouter.of(context)
                            .pop<List<DanceViewModel>>(state.selectedDances);
                      }
                    : null,
              );
            }
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(const DanceCreateRoute());
              },
              child: Icon(MdiIcons.plus),
            ),
            body: DanceListView(
              danceListBloc: danceListBloc,
              scrollDirection: Axis.vertical,
            ),
          );
        },
      ),
    );
  }
}
