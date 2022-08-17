import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PracticeListPage extends StatelessWidget
    implements AutoRouteWrapper, PracticeListParams {
  /// Page params
  final bool showAppBar;

  /// ListBloc params
  final PracticeListBloc? practiceListBloc;

  /// PracticeListParams
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

    /// ListBloc params
    this.practiceListBloc,

    /// PracticeListParams
    this.ofArtist,
    this.ofDance,
    this.ofFigure,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    final practiceListBloc = BlocProvider.of<PracticeListBloc>(context);

    return BlocBuilder<PracticeListBloc, PracticeListState>(
      builder: (context, state) {
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
              ? AppBar(
                  title: const Text('Practices'),
                )
              : null;
        }

        return Scaffold(
          appBar: appBar,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(PracticeEditRoute());
            },
            child: const Icon(MdiIcons.plus),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              practiceListBloc.add(const PracticeListRefresh());
              return practiceListBloc.stream
                  .firstWhere((e) => e.status != PracticeListStatus.refreshing);
            },
            child: PracticeListView(
              practiceListBloc: practiceListBloc,
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
    return (practiceListBloc != null)
        ? BlocProvider<PracticeListBloc>.value(
            value: practiceListBloc!,
            child: this,
          )
        : BlocProvider<PracticeListBloc>(
            create: (context) => PracticeListBloc(
              practiceRepository:
                  Provider.of<PracticeRepository>(context, listen: false),
              mapper: ModelMapper(),
            )..add(PracticeListLoad(
                ofArtist: ofArtist,
                ofDance: ofDance,
                ofFigure: ofFigure,
                ofVideo: ofVideo,
              )),
            child: this,
          );
  }
}
