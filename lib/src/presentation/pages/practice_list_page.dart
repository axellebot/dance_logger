import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class PracticeListPage extends StatelessWidget
    implements PracticeListWidgetParams {
  /// Page params
  final bool showAppBar;

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

    /// PracticeListWidgetParams
    this.practiceListBloc,
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  }) : assert(practiceListBloc == null ||
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
      child: BlocBuilder<PracticeListBloc, PracticeListState>(
        builder: (context, state) {
          final practiceListBloc = BlocProvider.of<PracticeListBloc>(context);
          final PreferredSizeWidget? appBar;
          if (state.selectedPractices.isNotEmpty) {
            appBar = SelectingAppBar(
              count: state.selectedPractices.length,
              onCanceled: () {
                practiceListBloc.add(const PracticeListUnselect());
              },
              onDeleted: () {
                practiceListBloc.add(const PracticeListDelete());
              },
            );
          } else {
            appBar = (showAppBar)
                ? const DanceAppBar(
                    title: Text('Practices'),
                  )
                : null;
          }

          return Scaffold(
            appBar: appBar,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                AutoRouter.of(context).push(PracticeCreateRoute());
              },
              child: const Icon(MdiIcons.plus),
            ),
            body: RefreshIndicator(
              onRefresh: () {
                practiceListBloc.add(const PracticeListRefresh());
                return practiceListBloc.stream.firstWhere(
                        (e) => e.status != PracticeListStatus.refreshing);
              },
              child: PracticeListView(
                practiceListBloc: practiceListBloc,
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
