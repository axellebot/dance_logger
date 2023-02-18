import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

@RoutePage<List<PracticeViewModel>>()
class PracticeListPage extends StatelessWidget
    implements EntityListPageParams, PracticeListWidgetParams {
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
  final List<PracticeViewModel>? preselectedItems;

  /// PracticeListWidgetParams
  @override
  final PracticeListBloc? practiceListBloc;
  @override
  final String? ofArtistId;
  @override
  final String? ofDanceId;
  @override
  final String? ofFigureId;
  @override
  final String? ofVideoId;

  const PracticeListPage({
    super.key,

    /// Page params
    this.showAppBar = true,
    this.titleText,
    this.shouldSelectOne = false,
    this.shouldSelectMultiple = false,
    this.preselectedItems,

    /// PracticeListWidgetParams
    this.practiceListBloc,
    this.ofArtistId,
    this.ofDanceId,
    this.ofFigureId,
    this.ofVideoId,
  })  : assert(shouldSelectOne == false || shouldSelectMultiple == false),
        assert(practiceListBloc == null ||
            (ofArtistId == null &&
                ofDanceId == null &&
                ofFigureId == null &&
                ofVideoId == null));

  @override
  Widget build(BuildContext context) {
    return PracticeListBlocProvider(
      practiceListBloc: practiceListBloc,
      ofArtistId: ofArtistId,
      ofDanceId: ofDanceId,
      ofFigureId: ofFigureId,
      ofVideoId: ofVideoId,
      preselectedPractices: preselectedItems,
      child: BlocBuilder<PracticeListBloc, PracticeListState>(
        builder: (context, state) {
          final practiceListBloc = BlocProvider.of<PracticeListBloc>(context);
          PreferredSizeWidget? appBar;
          if (showAppBar) {
            if (state.selectedPractices.isEmpty) {
              appBar = SearchAppBar(
                title:
                    (titleText != null) ? Text(titleText ?? 'Practices') : null,
                hintText: (titleText == null) ? 'Search practices' : null,
              );
            } else {
              appBar = SelectionAppBar(
                count: state.selectedPractices.length,
                onCanceled: () {
                  practiceListBloc.add(const PracticeListUnselect());
                },
                onDeleted: (state.selectedPractices.isNotEmpty)
                    ? () {
                        practiceListBloc.add(const PracticeListDelete());
                      }
                    : null,
                onConfirmed:
                    (state.selectedPractices.isNotEmpty && shouldSelectMultiple)
                        ? () {
                            AutoRouter.of(context).pop<List<PracticeViewModel>>(
                                state.selectedPractices);
                          }
                        : null,
              );
            }
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(const PracticeCreateRoute());
              },
              child: Icon(MdiIcons.plus),
            ),
            body: PracticeListView(
              practiceListBloc: practiceListBloc,
              scrollDirection: Axis.vertical,
            ),
          );
        },
      ),
    );
  }
}
