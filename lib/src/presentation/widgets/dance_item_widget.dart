import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class DanceDetailWidgetParams implements DanceDetailParams {
  final DanceDetailBloc? danceDetailBloc;
  final DanceViewModel? ofDance;

  DanceDetailWidgetParams(this.danceDetailBloc, this.ofDance);
}

class DanceDetailBlocProvider extends StatelessWidget implements DanceDetailWidgetParams {
  /// DanceDetailWidgetParams
  @override
  final DanceDetailBloc? danceDetailBloc;
  @override
  final DanceViewModel? ofDance;
  @override
  final String? ofDanceId;

  /// Widget params
  final Widget child;

  const DanceDetailBlocProvider({
    super.key,

    /// DanceDetailWidgetParams
    this.danceDetailBloc,
    this.ofDance,
    this.ofDanceId,

    /// Widget params
    required this.child,
  }) : assert(danceDetailBloc == null || ofDance == null || ofDanceId == null);

  @override
  Widget build(BuildContext context) {
    if (danceDetailBloc != null) {
      return BlocProvider<DanceDetailBloc>.value(
        value: danceDetailBloc!,
        child: child,
      );
    } else {
      return BlocProvider<DanceDetailBloc>(
        create: (context) {
          final danceDetailBloc = DanceDetailBloc(
            danceRepository: Provider.of<DanceRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (ofDance != null) {
            danceDetailBloc.add((DanceDetailLazyLoad(dance: ofDance!)));
          } else if (ofDanceId != null) {
            danceDetailBloc.add((DanceDetailLoad(danceId: ofDanceId!)));
          }

          return danceDetailBloc;
        },
        child: child,
      );
    }
  }
}

class DanceListTile extends StatelessWidget implements DanceDetailWidgetParams {
  /// DanceDetailWidgetParams
  @override
  final DanceDetailBloc? danceDetailBloc;
  @override
  final DanceViewModel? ofDance;
  @override
  final String? ofDanceId;

  /// ListTile parameters
  final ItemCallback<DanceViewModel>? onTap;
  final ItemCallback<DanceViewModel>? onLongPress;
  final bool selected;

  const DanceListTile({
    super.key,

    /// DanceDetailWidgetParams
    this.danceDetailBloc,
    this.ofDance,
    this.ofDanceId,

    /// ListTile parameters
    this.onTap,
    this.onLongPress,
    this.selected = false,
  }) : assert(danceDetailBloc == null || ofDance == null || ofDanceId == null);

  @override
  Widget build(BuildContext context) {
    return DanceDetailBlocProvider(
      danceDetailBloc: danceDetailBloc,
      ofDance: ofDance,
      ofDanceId: ofDanceId,
      child: BlocBuilder<DanceDetailBloc, DanceDetailState>(
        builder: (BuildContext context, DanceDetailState state) {
          return ListTile(
            title: Text(
              state.dance?.name ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            onTap: (onTap != null)
                ? () {
                    onTap!(state.dance!);
                  }
                : () {
                    AutoRouter.of(context).push(
                      DanceDetailsRoute(
                        danceDetailBloc: BlocProvider.of<DanceDetailBloc>(context),
                      ),
                    );
                  },
            onLongPress: (onLongPress != null)
                ? () {
                    onLongPress!(state.dance!);
                  }
                : null,
            selected: selected,
          );
        },
      ),
    );
  }
}

class CheckboxDanceListTile extends StatelessWidget implements DanceDetailWidgetParams {
  /// DanceDetailWidgetParams
  @override
  final DanceDetailBloc? danceDetailBloc;
  @override
  final DanceViewModel? ofDance;
  @override
  final String? ofDanceId;

  /// CheckboxLitTile parameters
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxDanceListTile({
    super.key,

    /// DanceDetailWidgetParams
    this.danceDetailBloc,
    this.ofDance,
    this.ofDanceId,

    /// CheckboxLitTile parameters
    required this.value,
    required this.onChanged,
  }) : assert(danceDetailBloc == null || ofDance == null || ofDanceId == null);

  @override
  Widget build(BuildContext context) {
    return DanceDetailBlocProvider(
      danceDetailBloc: danceDetailBloc,
      ofDance: ofDance,
      ofDanceId: ofDanceId,
      child: BlocBuilder<DanceDetailBloc, DanceDetailState>(
        builder: (BuildContext context, DanceDetailState state) {
          return CheckboxListTile(
            title: Text(
              state.dance?.name ?? '',
              overflow: TextOverflow.ellipsis,
            ),
            value: value,
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}

class DanceCard extends StatelessWidget implements DanceDetailWidgetParams {
  /// DanceDetailWidgetParams
  @override
  final DanceDetailBloc? danceDetailBloc;
  @override
  final DanceViewModel? ofDance;
  @override
  final String? ofDanceId;

  const DanceCard({
    super.key,

    /// DanceDetailWidgetParams
    this.danceDetailBloc,
    this.ofDance,
    this.ofDanceId,
  }) : assert(danceDetailBloc == null || ofDance == null || ofDanceId == null);

  @override
  Widget build(BuildContext context) {
    return DanceDetailBlocProvider(
      danceDetailBloc: danceDetailBloc,
      ofDance: ofDance,
      ofDanceId: ofDanceId,
      child: BlocBuilder<DanceDetailBloc, DanceDetailState>(
        builder: (BuildContext context, DanceDetailState state) {
          return Card(
            elevation: AppStyles.cardElevation,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: AppStyles.cardWidth,
              height: AppStyles.cardHeight,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    DanceDetailsRoute(
                      danceDetailBloc: BlocProvider.of<DanceDetailBloc>(context),
                    ),
                  );
                },
                child: Container(
                  padding: AppStyles.cardPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        state.dance?.name ?? '',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class DanceChip extends StatelessWidget {
  final DanceViewModel dance;

  const DanceChip({
    super.key,
    required this.dance,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Chip(
        label: Text(
          dance.name,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class DanceForm extends StatelessWidget {
  const DanceForm({super.key});

  @override
  Widget build(BuildContext context) {
    final DanceEditBloc danceEditBloc = BlocProvider.of<DanceEditBloc>(context);
    return BlocBuilder<DanceEditBloc, DanceEditState>(
      builder: (BuildContext context, DanceEditState state) {
        return Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Name',
                  hintText: 'Name',
                ),
                initialValue: state.initialDance?.name,
                onChanged: (value) {
                  danceEditBloc.add(DanceEditChangeName(danceName: value));
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
