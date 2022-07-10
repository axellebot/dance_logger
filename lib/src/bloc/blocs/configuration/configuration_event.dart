import 'package:equatable/equatable.dart';

/// [ConfigurationEvent] that must be dispatch to [AppBloc]
abstract class ConfigurationEvent extends Equatable {
  const ConfigurationEvent([List props = const []]);

  @override
  List<Object?> get props => [];

  @override
  String toString() => 'ConfigurationEvent{}';
}

class ConfigLoad extends ConfigurationEvent {}

class ConfigChange extends ConfigurationEvent {
  final String? fileName;

  const ConfigChange({required this.fileName});
}
