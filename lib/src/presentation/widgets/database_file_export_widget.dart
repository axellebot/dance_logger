import 'package:dance/bloc.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:share_plus/share_plus.dart';

class DatabaseFileExportTile extends StatelessWidget {
  const DatabaseFileExportTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, ConfigurationState state) {
        if (state is ConfigNotLoaded || state is ConfigLoaded) {
          bool enabled = false;
          GestureTapCallback? shareFct;
          if (state is ConfigLoaded) {
            enabled = true;
            shareFct =
                () => Share.shareFiles([join(state.fileDir, state.fileName)]);
          }
          return ListTile(
            enabled: enabled,
            title: const Text('Export'),
            onTap: shareFct,
          );
        }
        return const LoadingTile();
      },
    );
  }
}
