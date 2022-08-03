import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
