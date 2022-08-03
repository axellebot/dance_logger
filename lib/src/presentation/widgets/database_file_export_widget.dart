import 'package:dance/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';

class DatabaseFileExportTile extends StatelessWidget {
  const DatabaseFileExportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigState>(
      builder: (context, ConfigState state) {
        bool enabled = false;
        GestureTapCallback? shareFct;

        switch (state.status) {
          case ConfigStatus.ready:
            enabled = true;
            shareFct =
                () => Share.shareFiles([join(state.fileDir!, state.fileName!)]);
            break;
          case ConfigStatus.notReady:
            enabled = false;
            break;
        }
        return ListTile(
          enabled: enabled,
          title: const Text('Export'),
          onTap: shareFct,
        );
      },
    );
  }
}
