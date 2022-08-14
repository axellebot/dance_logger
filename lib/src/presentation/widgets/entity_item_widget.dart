import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DeleteIconButton extends StatelessWidget {
  final VoidCallback onDeleted;

  const DeleteIconButton({
    super.key,
    required this.onDeleted,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return DeleteDialog(
              onConfirmed: onDeleted,
            );
          },
        );
      },
      icon: const Icon(Icons.delete),
    );
  }
}

class EntityInfoListTile extends StatelessWidget {
  final DateTime? createdAt;
  final DateTime? updateAt;
  final int? version;

  const EntityInfoListTile({
    super.key,
    this.createdAt,
    this.updateAt,
    this.version,
  });

  @override
  Widget build(BuildContext context) {
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('Versioning'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (updateAt != null && version != null && version! > 1)
            Text('Updated at: ${dateFormat.format(updateAt!)}'),
          if (createdAt != null)
            Text('Created at: ${dateFormat.format(createdAt!)}'),
          if (version != null) Text('Version #${version!}'),
        ],
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  final VoidCallback? onSaved;

  const SaveButton({
    Key? key,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: FloatingActionButton.extended(
        label: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 7.5),
          child: Text('Save'),
        ),
        onPressed: onSaved,
      ),
    );
  }
}

class DeleteDialog extends StatelessWidget {
  final VoidCallback? onConfirmed;

  const DeleteDialog({super.key, this.onConfirmed});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Are you sure ?"),
      content: const Text("Deletion can't be reverted"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
            onConfirmed!();
          },
          child: const Text("Delete"),
        )
      ],
    );
  }
}
