import 'package:auto_route/auto_route.dart';
import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

abstract class PracticeDetailWidgetParams implements PracticeDetailParams {
  final PracticeDetailBloc? practiceDetailBloc;
  final PracticeViewModel? ofPractice;

  PracticeDetailWidgetParams(this.practiceDetailBloc, this.ofPractice);
}

class PracticeDetailBlocProvider extends StatelessWidget implements PracticeDetailWidgetParams {
  /// PracticeDetailWidgetParams
  @override
  final PracticeDetailBloc? practiceDetailBloc;
  @override
  final PracticeViewModel? ofPractice;
  @override
  final String? ofPracticeId;

  /// Widget params
  final Widget child;

  const PracticeDetailBlocProvider({
    super.key,

    /// PracticeDetailWidgetParams
    this.practiceDetailBloc,
    this.ofPractice,
    this.ofPracticeId,

    /// Widget params
    required this.child,
  }) : assert(practiceDetailBloc == null || ofPractice == null || ofPracticeId == null);

  @override
  Widget build(BuildContext context) {
    if (practiceDetailBloc != null) {
      return BlocProvider<PracticeDetailBloc>.value(
        value: practiceDetailBloc!,
        child: child,
      );
    } else {
      return BlocProvider<PracticeDetailBloc>(
        create: (context) {
          final practiceDetailBloc = PracticeDetailBloc(
            practiceRepository: Provider.of<PracticeRepository>(context, listen: false),
            mapper: ModelMapper(),
          );

          if (ofPractice != null) {
            practiceDetailBloc.add((PracticeDetailLazyLoad(practice: ofPractice!)));
          } else if (ofPracticeId != null) {
            practiceDetailBloc.add((PracticeDetailLoad(practiceId: ofPracticeId!)));
          }

          return practiceDetailBloc;
        },
        child: child,
      );
    }
  }
}

class PracticeListTile extends StatelessWidget implements PracticeDetailWidgetParams {
  /// PracticeDetailWidgetParams
  @override
  final PracticeDetailBloc? practiceDetailBloc;
  @override
  final PracticeViewModel? ofPractice;
  @override
  final String? ofPracticeId;

  /// ListTile parameters
  final ItemCallback<PracticeViewModel>? onTap;
  final ItemCallback<PracticeViewModel>? onLongPress;
  final bool selected;

  const PracticeListTile({
    super.key,

    /// PracticeDetailWidgetParams
    this.practiceDetailBloc,
    this.ofPractice,
    this.ofPracticeId,

    /// ListTile parameters
    this.onTap,
    this.onLongPress,
    this.selected = false,
  }) : assert(practiceDetailBloc == null || ofPractice == null || ofPracticeId == null);

  @override
  Widget build(BuildContext context) {
    return PracticeDetailBlocProvider(
      practiceDetailBloc: practiceDetailBloc,
      ofPractice: ofPractice,
      ofPracticeId: ofPracticeId,
      child: BlocBuilder<PracticeDetailBloc, PracticeDetailState>(
        builder: (BuildContext context, PracticeDetailState state) {
          return ListTile(
            title: Text(
              '${state.practice?.doneAt}',
              overflow: TextOverflow.ellipsis,
            ),
            onTap: (onTap != null)
                ? () {
                    onTap!(state.practice!);
                  }
                : () {
                    AutoRouter.of(context).push(
                      PracticeDetailsRoute(
                        practiceDetailBloc: BlocProvider.of<PracticeDetailBloc>(context),
                      ),
                    );
                  },
            onLongPress: (onLongPress != null)
                ? () {
                    onLongPress!(state.practice!);
                  }
                : null,
            selected: selected,
          );
        },
      ),
    );
  }
}

class CheckboxPracticeListTile extends StatelessWidget implements PracticeDetailWidgetParams {
  /// PracticeDetailWidgetParams
  @override
  final PracticeDetailBloc? practiceDetailBloc;
  @override
  final PracticeViewModel? ofPractice;
  @override
  final String? ofPracticeId;

  /// CheckboxLitTile parameters
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxPracticeListTile({
    super.key,

    /// PracticeDetailWidgetParams
    this.practiceDetailBloc,
    this.ofPractice,
    this.ofPracticeId,

    /// CheckboxLitTile parameters
    required this.value,
    required this.onChanged,
  }) : assert(practiceDetailBloc == null || ofPractice == null || ofPracticeId == null);

  @override
  Widget build(BuildContext context) {
    return PracticeDetailBlocProvider(
      practiceDetailBloc: practiceDetailBloc,
      ofPractice: ofPractice,
      ofPracticeId: ofPracticeId,
      child: BlocBuilder<PracticeDetailBloc, PracticeDetailState>(
        builder: (BuildContext context, PracticeDetailState state) {
          return CheckboxListTile(
            title: Text(
              '${state.practice?.doneAt}',
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

class PracticeCard extends StatelessWidget implements PracticeDetailWidgetParams {
  /// PracticeDetailWidgetParams
  @override
  final PracticeDetailBloc? practiceDetailBloc;
  @override
  final PracticeViewModel? ofPractice;
  @override
  final String? ofPracticeId;

  const PracticeCard({
    super.key,

    /// PracticeDetailWidgetParams
    this.practiceDetailBloc,
    this.ofPractice,
    this.ofPracticeId,
  }) : assert(practiceDetailBloc == null || ofPractice == null || ofPracticeId == null);

  @override
  Widget build(BuildContext context) {
    return PracticeDetailBlocProvider(
      practiceDetailBloc: practiceDetailBloc,
      ofPractice: ofPractice,
      ofPracticeId: ofPracticeId,
      child: BlocBuilder<PracticeDetailBloc, PracticeDetailState>(
        builder: (BuildContext context, PracticeDetailState state) {
          return Card(
            elevation: AppStyles.cardElevation,
            clipBehavior: Clip.antiAlias,
            child: SizedBox(
              width: AppStyles.cardWidth,
              height: AppStyles.cardHeight,
              child: InkWell(
                onTap: () {
                  AutoRouter.of(context).push(
                    PracticeDetailsRoute(
                      practiceDetailBloc: BlocProvider.of<PracticeDetailBloc>(context),
                    ),
                  );
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: <Widget>[
                    Text(
                      '${state.practice?.doneAt}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class PracticeForm extends StatefulWidget {
  const PracticeForm({super.key});

  @override
  State<StatefulWidget> createState() => _PracticeFormState();
}

class _PracticeFormState extends State<PracticeForm> {
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(controller: nameController),
        ],
      ),
    );
  }
}
