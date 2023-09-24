import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class FigureDetailWidgetParams implements FigureDetailParams {
  final FigureDetailBloc? figureDetailBloc;
  final FigureViewModel? ofFigure;

  FigureDetailWidgetParams(this.figureDetailBloc, this.ofFigure);
}

class FigureDetailBlocProvider extends StatelessWidget implements FigureDetailWidgetParams {
  /// FigureDetailWidgetParams
  @override
  final FigureDetailBloc? figureDetailBloc;
  @override
  final FigureViewModel? ofFigure;
  @override
  final String? ofFigureId;

  /// Widget params
  final Widget child;

  const FigureDetailBlocProvider({
    super.key,

    /// FigureDetailWidgetParams
    this.figureDetailBloc,
    this.ofFigure,
    this.ofFigureId,

    /// Widget params
    required this.child,
  }) : assert(figureDetailBloc == null || ofFigure == null || ofFigureId == null);

  @override
  Widget build(BuildContext context) {
    if (figureDetailBloc != null) {
      return BlocProvider<FigureDetailBloc>.value(
        value: figureDetailBloc!,
        child: child,
      );
    } else {
      return BlocProvider<FigureDetailBloc>(
        create: (context) {
          final figureDetailBloc = FigureDetailBloc(
            figureRepository: Provider.of<FigureRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (ofFigure != null) {
            figureDetailBloc.add((FigureDetailLazyLoad(figure: ofFigure!)));
          } else if (ofFigureId != null) {
            figureDetailBloc.add((FigureDetailLoad(figureId: ofFigureId!)));
          }

          return figureDetailBloc;
        },
        child: child,
      );
    }
  }
}

class FigureListTile extends StatelessWidget implements FigureDetailWidgetParams {
  /// FigureDetailWidgetParams
  @override
  final FigureDetailBloc? figureDetailBloc;
  @override
  final FigureViewModel? ofFigure;
  @override
  final String? ofFigureId;

  /// ListTile parameters
  final ItemCallback<FigureViewModel>? onTap;
  final ItemCallback<FigureViewModel>? onLongPress;
  final bool selected;

  const FigureListTile({
    super.key,

    /// FigureDetailWidgetParams
    this.figureDetailBloc,
    this.ofFigure,
    this.ofFigureId,

    /// ListTile parameters
    this.onTap,
    this.onLongPress,
    this.selected = false,
  }) : assert(figureDetailBloc == null || ofFigure == null || ofFigureId == null);

  @override
  Widget build(BuildContext context) {
    return FigureDetailBlocProvider(
      figureDetailBloc: figureDetailBloc,
      ofFigure: ofFigure,
      ofFigureId: ofFigureId,
      child: BlocBuilder<FigureDetailBloc, FigureDetailState>(
        builder: (BuildContext context, FigureDetailState state) {
          return ListTile(
            title: Text(
              '${state.figure?.name}',
              overflow: TextOverflow.ellipsis,
            ),
            onTap: (onTap != null)
                ? () {
                    onTap!(state.figure!);
                  }
                : () {
                    AutoRouter.of(context).push(
                      FigureDetailsRoute(
                        figureDetailBloc: BlocProvider.of<FigureDetailBloc>(context),
                      ),
                    );
                  },
            onLongPress: (onLongPress != null)
                ? () {
                    onLongPress!(state.figure!);
                  }
                : null,
            selected: selected,
          );
        },
      ),
    );
  }
}

class CheckboxFigureListTile extends StatelessWidget implements FigureDetailWidgetParams {
  /// FigureDetailWidgetParams
  @override
  final FigureDetailBloc? figureDetailBloc;
  @override
  final FigureViewModel? ofFigure;
  @override
  final String? ofFigureId;

  /// CheckboxLitTile parameters
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxFigureListTile({
    super.key,

    /// FigureDetailWidgetParams
    this.figureDetailBloc,
    this.ofFigure,
    this.ofFigureId,

    /// CheckboxLitTile parameters
    required this.value,
    required this.onChanged,
  }) : assert(figureDetailBloc == null || ofFigure == null || ofFigureId == null);

  @override
  Widget build(BuildContext context) {
    return FigureDetailBlocProvider(
      figureDetailBloc: figureDetailBloc,
      ofFigure: ofFigure,
      ofFigureId: ofFigureId,
      child: BlocBuilder<FigureDetailBloc, FigureDetailState>(
        builder: (BuildContext context, FigureDetailState state) {
          return CheckboxListTile(
            title: Text(
              '${state.figure?.name}',
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

class FigureCard extends StatelessWidget implements FigureDetailWidgetParams {
  /// FigureDetailWidgetParams
  @override
  final FigureDetailBloc? figureDetailBloc;
  @override
  final FigureViewModel? ofFigure;
  @override
  final String? ofFigureId;

  const FigureCard({
    super.key,

    /// FigureDetailWidgetParams
    this.figureDetailBloc,
    this.ofFigure,
    this.ofFigureId,
  }) : assert(figureDetailBloc == null || ofFigure == null || ofFigureId == null);

  @override
  Widget build(BuildContext context) {
    return FigureDetailBlocProvider(
      figureDetailBloc: figureDetailBloc,
      ofFigure: ofFigure,
      ofFigureId: ofFigureId,
      child: BlocBuilder<FigureDetailBloc, FigureDetailState>(
        builder: (BuildContext context, FigureDetailState state) {
          return Card(
            elevation: AppStyles.cardElevation,
            clipBehavior: Clip.antiAlias,
            child: AspectRatio(
              aspectRatio: AppStyles.figureCardRatio,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    FigureDetailsRoute(
                      figureDetailBloc: BlocProvider.of<FigureDetailBloc>(context),
                    ),
                  );
                },
                child: Container(
                  padding: AppStyles.cardPadding,
                  child: Center(
                    child: Text(
                      '${state.figure?.name}',
                      overflow: TextOverflow.ellipsis,
                    ),
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

class FigureTextForMoment extends StatelessWidget implements FigureDetailWidgetParams {
  /// FigureDetailWidgetParams
  @override
  final FigureDetailBloc? figureDetailBloc;
  @override
  final FigureViewModel? ofFigure;
  @override
  final String? ofFigureId;

  const FigureTextForMoment({
    super.key,

    /// FigureDetailWidgetParams
    this.figureDetailBloc,
    this.ofFigure,
    this.ofFigureId,
  }) : assert(figureDetailBloc == null || ofFigure == null || ofFigureId == null, "");

  @override
  Widget build(BuildContext context) {
    return FigureDetailBlocProvider(
      figureDetailBloc: figureDetailBloc,
      ofFigure: ofFigure,
      ofFigureId: ofFigureId,
      child: BlocBuilder<FigureDetailBloc, FigureDetailState>(
        builder: (BuildContext context, FigureDetailState state) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${state.figure?.name}',
                overflow: TextOverflow.ellipsis,
              ),
              IconButton(
                onPressed: () {
                  AutoRouter.of(context).push(
                    FigureDetailsRoute(
                      figureDetailBloc: BlocProvider.of<FigureDetailBloc>(context),
                    ),
                  );
                },
                icon: const Icon(Icons.info_outline),
              ),
            ],
          );
        },
      ),
    );
  }
}
