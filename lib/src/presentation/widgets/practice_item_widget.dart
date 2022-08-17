import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class PracticeListTile extends StatelessWidget {
  final PracticeViewModel practice;

  /// ListTile options
  final GestureTapCallback? onTap;
  final GestureLongPressCallback? onLongPress;
  final bool selected;

  const PracticeListTile({
    super.key,
    required this.practice,

    /// ListTile options
    this.onTap,
    this.onLongPress,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${practice.doneAt}'),
      onTap: onTap ??
          () {
            AutoRouter.of(context).push(
              PracticeDetailsRoute(practiceId: practice.id),
            );
          },
      onLongPress: onLongPress,
      selected: selected,
    );
  }
}

class CheckboxPracticeListTile extends StatelessWidget {
  final PracticeViewModel practice;

  /// CheckboxLitTile options
  final bool? value;
  final ValueChanged<bool?>? onChanged;

  const CheckboxPracticeListTile({
    super.key,
    required this.practice,

    /// CheckboxLitTile options
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text('${practice.doneAt}'),
      value: value,
      onChanged: onChanged,
    );
  }
}

class PracticeCard extends StatelessWidget {
  final PracticeViewModel practice;

  const PracticeCard({
    super.key,
    required this.practice,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppStyles.cardHeight,
      width: AppStyles.cardWidth,
      child: Card(
        elevation: AppStyles.cardElevation,
        child: GestureDetector(
          onTap: () => AutoRouter.of(context).push(
            PracticeDetailsRoute(practiceId: practice.id),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Text(
                '${practice.doneAt}',
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
