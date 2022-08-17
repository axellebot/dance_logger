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
  /// Page params
  final bool showAppBar;

  /// ListBloc params
  final FigureListBloc? figureListBloc;

  /// FigureListParams
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

    /// ListBloc params
    this.figureListBloc,

    /// FigureListParams
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
            child: FigureListView(
              figureListBloc: figureListBloc,
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
    return (figureListBloc != null)
        ? BlocProvider<FigureListBloc>.value(
            value: figureListBloc!,
            child: this,
          )
        : BlocProvider<FigureListBloc>(
            create: (_) => FigureListBloc(
              figureRepository:
                  Provider.of<FigureRepository>(context, listen: false),
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
