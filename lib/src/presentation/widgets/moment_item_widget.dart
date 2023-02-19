import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class MomentDetailWidgetParams implements MomentDetailParams {
  final MomentDetailBloc? momentDetailBloc;
  final MomentViewModel? ofMoment;

  MomentDetailWidgetParams(this.momentDetailBloc, this.ofMoment);
}

class MomentDetailBlocProvider extends StatelessWidget implements MomentDetailWidgetParams {
  /// MomentDetailWidgetParams
  @override
  final MomentDetailBloc? momentDetailBloc;
  @override
  final MomentViewModel? ofMoment;
  @override
  final String? ofMomentId;

  /// Widget params
  final Widget child;

  const MomentDetailBlocProvider({
    super.key,

    /// MomentDetailWidgetParams
    this.momentDetailBloc,
    this.ofMoment,
    this.ofMomentId,

    /// Widget params
    required this.child,
  }) : assert(momentDetailBloc == null || ofMoment == null || ofMomentId == null);

  @override
  Widget build(BuildContext context) {
    if (momentDetailBloc != null) {
      return BlocProvider<MomentDetailBloc>.value(
        value: momentDetailBloc!,
        child: child,
      );
    } else {
      return BlocProvider<MomentDetailBloc>(
        create: (context) {
          final momentDetailBloc = MomentDetailBloc(
            momentRepository: Provider.of<MomentRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (ofMoment != null) {
            momentDetailBloc.add((MomentDetailLazyLoad(moment: ofMoment!)));
          } else if (ofMomentId != null) {
            momentDetailBloc.add((MomentDetailLoad(momentId: ofMomentId!)));
          }

          return momentDetailBloc;
        },
        child: child,
      );
    }
  }
}

class MomentListTile extends StatelessWidget implements MomentDetailWidgetParams {
  /// MomentDetailWidgetParams
  @override
  final MomentDetailBloc? momentDetailBloc;
  @override
  final MomentViewModel? ofMoment;
  @override
  final String? ofMomentId;

  /// ListTile parameters
  final ItemCallback<MomentViewModel>? onTap;
  final ItemCallback<MomentViewModel>? onLongPress;
  final bool selected;

  const MomentListTile({
    super.key,

    /// MomentDetailWidgetParams
    this.momentDetailBloc,
    this.ofMoment,
    this.ofMomentId,

    /// ListTile parameters
    this.onTap,
    this.onLongPress,
    this.selected = false,
  }) : assert(momentDetailBloc == null || ofMoment == null || ofMomentId == null);

  @override
  Widget build(BuildContext context) {
    return MomentDetailBlocProvider(
      momentDetailBloc: momentDetailBloc,
      ofMoment: ofMoment,
      ofMomentId: ofMomentId,
      child: BlocBuilder<MomentDetailBloc, MomentDetailState>(
        builder: (BuildContext context, MomentDetailState state) {
          return ListTile(
            title: (state.moment != null)
                ? (state.moment?.endTime != null)
                    ? Text('${printDuration(state.moment?.startTime)}-${printDuration(state.moment?.endTime)}')
                    : Text('${printDuration(state.moment?.startTime)}')
                : const Text('Loading ...'),

            /// TODO: Add shimmer text

            subtitle: (state.moment != null) ? FigureTextForMoment(ofFigureId: state.moment?.figureId) : null,
            onTap: (onTap != null)
                ? () {
                    onTap!(state.moment!);
                  }
                : null,
            onLongPress: (onLongPress != null)
                ? () {
                    onLongPress!(state.moment!);
                  }
                : null,
            selected: selected,
          );
        },
      ),
    );
  }
}

class CheckboxMomentListTile extends StatelessWidget implements MomentDetailWidgetParams {
  /// MomentDetailWidgetParams
  @override
  final MomentDetailBloc? momentDetailBloc;
  @override
  final MomentViewModel? ofMoment;
  @override
  final String? ofMomentId;

  /// CheckboxLitTile parameters
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxMomentListTile({
    super.key,

    /// MomentDetailWidgetParams
    this.momentDetailBloc,
    this.ofMoment,
    this.ofMomentId,

    /// CheckboxLitTile parameters
    required this.value,
    required this.onChanged,
  }) : assert(momentDetailBloc == null || ofMoment == null || ofMomentId == null);

  @override
  Widget build(BuildContext context) {
    return MomentDetailBlocProvider(
      momentDetailBloc: momentDetailBloc,
      ofMoment: ofMoment,
      ofMomentId: ofMomentId,
      child: BlocBuilder<MomentDetailBloc, MomentDetailState>(
        builder: (BuildContext context, MomentDetailState state) {
          return CheckboxListTile(
            title: (state.moment != null)
                ? (state.moment?.endTime != null)
                    ? Text('${printDuration(state.moment?.startTime)}-${printDuration(state.moment?.endTime)}')
                    : Text('${printDuration(state.moment?.startTime)}')
                : const Text('Loading ...'),

            /// TODO: Add shimmer text
            value: value,
            onChanged: onChanged,
          );
        },
      ),
    );
  }
}

class MomentChip extends StatelessWidget implements MomentDetailWidgetParams {
  /// MomentDetailWidgetParams
  @override
  final MomentDetailBloc? momentDetailBloc;
  @override
  final MomentViewModel? ofMoment;
  @override
  final String? ofMomentId;

  /// Chip parameters
  final ItemCallback<MomentViewModel>? onTap;

  const MomentChip({
    super.key,

    /// MomentDetailWidgetParams
    this.momentDetailBloc,
    this.ofMoment,
    this.ofMomentId,

    /// Chip parameters
    this.onTap,
  }) : assert(momentDetailBloc == null || ofMoment == null || ofMomentId == null);

  @override
  Widget build(BuildContext context) {
    return MomentDetailBlocProvider(
      momentDetailBloc: momentDetailBloc,
      ofMoment: ofMoment,
      ofMomentId: ofMomentId,
      child: BlocBuilder<MomentDetailBloc, MomentDetailState>(
        builder: (BuildContext context, MomentDetailState state) {
          return GestureDetector(
            onTap: () {
              if (onTap != null) {
                onTap!(state.moment!);
              }
            },
            child: Chip(
              label: (state.moment?.endTime != null)
                  ? Text('${printDuration(state.moment?.startTime)}-${printDuration(state.moment?.endTime!)}')
                  : Text(printDuration(state.moment?.startTime)!),
              deleteIcon: const Icon(Icons.edit),
              onDeleted: () {
                AutoRouter.of(context).push(MomentEditRoute(momentId: state.moment?.id));
              },
              deleteButtonTooltipMessage: 'Edit',
            ),
          );
        },
      ),
    );
  }
}

class MomentForm extends StatefulWidget {
  const MomentForm({super.key});

  @override
  State<MomentForm> createState() => _MomentFormState();
}

class _MomentFormState extends State<MomentForm> {
  // final TextEditingController startField = TextEditingController();
  // final TextEditingController endField = TextEditingController();
  // final TextEditingController figureField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final MomentEditBloc momentEditBloc = BlocProvider.of<MomentEditBloc>(context);
    return BlocListener<MomentEditBloc, MomentEditState>(
      listener: (context, state) {
        // String? startFieldValue =
        //     printDuration(state.startTime ?? state.initialMoment?.startTime);
        // if (startFieldValue != null) {
        //   startField.text = startFieldValue!;
        // } else {
        //   startField.clear();
        // }
        //
        // String? endFieldValue;
        // if (state.endTime != null) {
        //   endFieldValue = printDuration(state.endTime?.orNull);
        // } else if (state.initialMoment?.endTime != null) {
        //   endFieldValue = printDuration(state.initialMoment?.endTime);
        // }
        // if (endFieldValue != null) {
        //   endField.text = endFieldValue!;
        // } else {
        //   endField.clear();
        // }
        //
        // figureField.text =
        //     state.figure?.name ?? state.initialFigure?.name ?? '';
      },
      child: BlocBuilder<MomentEditBloc, MomentEditState>(
        builder: (BuildContext context, MomentEditState state) {
          Duration? initialStartTime = state.startTime ?? state.initialMoment?.startTime;
          Duration? initialEndTime;
          if (state.endTime != null) {
            initialEndTime = state.endTime!.orNull;
          } else {
            initialEndTime = state.initialMoment?.endTime;
          }
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  // controller: startField,
                  decoration: const InputDecoration(
                    labelText: 'Start Time',
                    hintText: 'Start Time',
                  ),
                  initialValue: printDuration(initialStartTime),
                  onTap: () async {
                    Duration? resultingDuration = await showDurationPicker(
                      context: context,
                      initialTime: initialStartTime ?? const Duration(),
                      baseUnit: BaseUnit.second,
                    );
                    if (resultingDuration != null) {
                      momentEditBloc.add(MomentEditChangeStartTime(
                        startTime: resultingDuration,
                      ));
                    }
                  },
                ),
                const SizedBox(
                  height: AppStyles.formInputVerticalSpacing,
                ),
                TextFormField(
                  // controller: endField,
                  decoration: InputDecoration(
                    labelText: 'End Time',
                    hintText: 'End Time',
                    suffixIcon: IconButton(
                      onPressed: () {
                        momentEditBloc.add(const MomentEditChangeEndTime(
                          endTime: null,
                        ));
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                  initialValue: printDuration(initialEndTime),
                  onTap: () async {
                    Duration? resultingDuration = await showDurationPicker(
                      context: context,
                      initialTime: initialEndTime ?? const Duration(),
                      baseUnit: BaseUnit.second,
                    );
                    if (resultingDuration != null) {
                      momentEditBloc.add(MomentEditChangeEndTime(
                        endTime: resultingDuration,
                      ));
                    }
                  },
                ),
                const SizedBox(
                  height: AppStyles.formInputVerticalSpacing,
                ),
                TextButton(
                  onPressed: () async {
                    List<ArtistViewModel>? artists =
                        await AutoRouter.of(context).push<List<ArtistViewModel>>(ArtistListRoute(
                      shouldSelectMultiple: true,
                      preselectedItems: state.artists ?? state.initialArtists,
                    ));
                    if (artists != null) {
                      momentEditBloc.add(MomentEditChangeArtists(artists: artists));
                    }
                  },
                  child: const Text('Add artist'),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.artists?.length ?? state.initialArtists?.length ?? 0,
                  itemBuilder: (context, index) {
                    ArtistViewModel? item = state.artists?[index] ?? state.initialArtists?[index];

                    return Dismissible(
                      key: Key(item!.id),
                      onDismissed: (direction) {
                        momentEditBloc.add(MomentEditRemoveArtist(item));
                      },
                      background: Container(color: Colors.red),
                      child: ListTile(
                        title: Text(item.name),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: AppStyles.formInputVerticalSpacing,
                ),
                TextFormField(
                  // controller: figureField,
                  decoration: InputDecoration(
                    labelText: 'Figure',
                    hintText: 'Figure',
                    suffixIcon: IconButton(
                      onPressed: () async {
                        momentEditBloc.add(const MomentEditChangeFigure(
                          figure: null,
                        ));
                      },
                      icon: const Icon(Icons.restore),
                    ),
                  ),
                  initialValue: state.figure?.name ?? state.initialFigure?.name,
                  onTap: () async {
                    List<FigureViewModel>? results =
                        await AutoRouter.of(context).push<List<FigureViewModel>>(FigureListRoute(
                      shouldSelectOne: true,
                    ));
                    if (results?.isNotEmpty ?? false) {
                      momentEditBloc.add(MomentEditChangeFigure(
                        figure: results!.first,
                      ));
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
