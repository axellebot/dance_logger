import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';

class EntityInfoListTile extends StatelessWidget {
  final String? createdAt;
  final String? updateAt;
  final String? version;

  const EntityInfoListTile({
    super.key,
    this.createdAt,
    this.updateAt,
    this.version,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.info_outline),
      title: const Text('Versioning'),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(createdAt!),
          Text(updateAt!),
          Text(version!),
        ],
      ),
    );
  }
}
