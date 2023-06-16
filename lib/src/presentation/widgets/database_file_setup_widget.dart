import 'package:dance/bloc.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class DatabaseFileSetupTile extends StatelessWidget {
  const DatabaseFileSetupTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationBloc, ConfigState>(
      builder: (context, state) {
        switch (state.status) {
          case ConfigStatus.initial:
          case ConfigStatus.loading:
            return const LoadingTile();
          case ConfigStatus.ready:
            String? dirPath;
            String? fileName;
            dirPath = state.fileDir;
            fileName = state.fileName;
            return ListTile(
              leading: Icon(MdiIcons.file),
              trailing: Icon(MdiIcons.pencil),
              title: const Text(
                'Change file name',
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Directory: $dirPath'),
                  Text('Filename: $fileName'),
                ],
              ),
              onTap: () {
                openFileSetting(context);
              },
            );
          case ConfigStatus.failure:
            return ErrorTile(error: state.error);
          default:
            return ErrorTile(
              error: NotSupportedError(message: '${state.status}'),
            );
        }
      },
    );
  }
}

class DatabaseFileSettingDialog extends StatelessWidget {
  const DatabaseFileSettingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigurationBloc configBloc =
        BlocProvider.of<ConfigurationBloc>(context);
    final formKey = GlobalKey<FormState>();

    final fieldController = TextEditingController();

    ConfigState state = configBloc.state;
    _refreshController(state, fieldController);

    return BlocListener<ConfigurationBloc, ConfigState>(
      bloc: configBloc,
      listener: (context, state) {
        _refreshController(state, fieldController);
      },
      child: AlertDialog(
        title: const Text('Edit file name'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: fieldController,
            validator: (value) => value == null || value.isEmpty
                ? 'Please enter a file name'
                : null,
            decoration: const InputDecoration(
              labelText: 'File Name',
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            child: const Text('Reset'),
            onPressed: () {
              configBloc.add(const ConfigChange(
                fileDir: null,
                fileName: null,
              ));
            },
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                configBloc.add(ConfigChange(
                  fileDir: null,

                  /// TODO: Replace when flutter will have device explorer capability
                  fileName: fieldController.text,
                ));
              }
            },
          ),
        ],
      ),
    );
  }

  void _refreshController(
    ConfigState state,
    TextEditingController fieldController,
  ) {
    switch (state.status) {
      case ConfigStatus.ready:
        fieldController.text = state.fileName!;
        break;
      default:
        fieldController.text = '';
    }
  }
}
