import 'package:auto_route/auto_route.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class PracticeItemTile extends StatelessWidget {
  final PracticeViewModel practice;

  const PracticeItemTile({
    super.key,
    required this.practice,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text('${practice.doneAt}'),
      onTap: () => AutoRouter.of(context).push(
        PracticeDetailsRoute(practiceId: practice.id),
      ),
    );
  }
}

class PracticeItemCard extends StatelessWidget {
  final PracticeViewModel practice;

  const PracticeItemCard({
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
