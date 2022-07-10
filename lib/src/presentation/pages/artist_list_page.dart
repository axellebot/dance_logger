import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

class ArtistListPage extends StatelessWidget implements AutoRouteWrapper {
  const ArtistListPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const ArtistListView();
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    final repo = Provider.of<ArtistRepository>(context, listen: false);

    return BlocProvider<ArtistListBloc>(
      create: (_) => ArtistListBloc(
        artistRepository: repo,
        mapper: ModelMapper(),
      )..add(const ArtistListLoadMore()),
      child: this,
    );
  }
}
