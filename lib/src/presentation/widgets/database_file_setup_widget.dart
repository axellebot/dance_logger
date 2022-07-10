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
    return BlocBuilder<ConfigurationBloc, ConfigurationState>(
      builder: (context, state) {
        if (state is ConfigLoading) {
          return const LoadingTile();
        } else if (state is ConfigNotLoaded || state is ConfigLoaded) {
          String? dirPath;
          String? fileName;
          if (state is ConfigLoaded) {
            dirPath = state.fileDir;
            fileName = state.fileName;
          }
          return ListTile(
            leading: const Icon(MdiIcons.file),
            trailing: const Icon(MdiIcons.pencil),
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
            onTap: () => openFileSetting(context),
          );
        }
        return ErrorTile(error: NotSupportedError());
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

    ConfigurationState state = configBloc.state;
    _refreshController(state, fieldController);

    return BlocListener<ConfigurationBloc, ConfigurationState>(
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
                fileName: null,
              ));
            },
          ),
          ElevatedButton(
            child: const Text('Save'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                configBloc.add(ConfigChange(
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
      ConfigurationState state, TextEditingController fieldController) {
    if (state is ConfigNotLoaded) {
      fieldController.text = '';
    } else if (state is ConfigLoaded) {
      fieldController.text = state.fileName;
    }
  }
}
