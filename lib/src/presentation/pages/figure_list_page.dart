import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class FigureListPage extends StatelessWidget
    implements AutoRouteWrapper, FigureListParams {
  final bool showAppBar;
  final FigureListBloc? figureListBloc;

  /// Figure list params
  @override
  final String? ofArtist;
  @override
  final String? ofDance;
  @override
  final String? ofVideo;

  const FigureListPage({
    super.key,
    this.showAppBar = true,
    this.figureListBloc,

    /// Figure list params
    this.ofArtist,
    this.ofDance,
    this.ofVideo,
  });

  @override
  Widget build(BuildContext context) {
    final figureListBloc = BlocProvider.of<FigureListBloc>(context);

    return BlocBuilder<FigureListBloc, FigureListState>(
      builder: (context, state) {
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
              ? AppBar(
                  title: const Text('Figures'),
                )
              : null;
        }

        return Scaffold(
          appBar: appBar,
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              AutoRouter.of(context).push(FigureEditRoute());
            },
            child: const Icon(MdiIcons.plus),
          ),
          body: RefreshIndicator(
            onRefresh: () {
              figureListBloc.add(const FigureListRefresh());
              return figureListBloc.stream
                  .firstWhere((e) => e.status != FigureListStatus.refreshing);
            },
            child: const FigureListView(
              scrollDirection: Axis.vertical,
              physics: AlwaysScrollableScrollPhysics(),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    if (figureListBloc != null) {
      return BlocProvider<FigureListBloc>.value(
        value: figureListBloc!,
        child: this,
      );
    } else {
      final repo = Provider.of<FigureRepository>(context, listen: false);
      return BlocProvider<FigureListBloc>(
        create: (_) => FigureListBloc(
          figureRepository: repo,
          mapper: ModelMapper(),
        )..add(FigureListLoad(
            ofArtist: ofArtist,
            ofDance: ofDance,
            ofVideo: ofVideo,
          )),
        child: this,
      );
    }
  }
}
