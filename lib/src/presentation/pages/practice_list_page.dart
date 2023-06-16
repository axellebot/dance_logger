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
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofFigure;
  @override
  final String? ofVideo;

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
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  })  : assert(shouldSelectOne == false || shouldSelectMultiple == false),
        assert(practiceListBloc == null ||
            (ofArtist == null &&
                ofDance == null &&
                ofFigure == null &&
                ofVideo == null));

  @override
  Widget build(BuildContext context) {
    return PracticeListBlocProvider(
      practiceListBloc: practiceListBloc,
      ofArtist: ofArtist,
      ofDance: ofDance,
      ofFigure: ofFigure,
      ofVideo: ofVideo,
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
