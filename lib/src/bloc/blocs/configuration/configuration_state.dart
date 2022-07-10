import 'package:dance/domain.dart';
import 'package:equatable/equatable.dart';

abstract class ConfigurationState extends Equatable {
  const ConfigurationState();

  @override
  String toString() => 'ConfigurationState{}';
}

class ConfigLoading extends ConfigurationState {
  @override
  List<Object> get props => [];
}

class ConfigNotLoaded extends ConfigurationState {
  final AppPrefsRepository appPrefsRepository;

  const ConfigNotLoaded({required this.appPrefsRepository});

  @override
  List<Object> get props => [appPrefsRepository];
}

class ConfigLoaded extends ConfigurationState {
  final AppPrefsRepository appPrefsRepository;

  final String fileDir;
  final String fileName;

  final DanceRepository danceRepository;
  final ArtistRepository artistRepository;
  final VideoRepository videoRepository;
  final FigureRepository figureRepository;
  final PracticeRepository practiceRepository;

  const ConfigLoaded({
    required this.fileDir,
    required this.fileName,
    required this.appPrefsRepository,
    required this.danceRepository,
    required this.artistRepository,
    required this.videoRepository,
    required this.figureRepository,
    required this.practiceRepository,
  });

  @override
  List<Object> get props => [
        fileDir,
        fileName,
        appPrefsRepository,
        danceRepository,
        artistRepository,
        videoRepository,
        figureRepository,
        practiceRepository,
      ];
}

class ConfigFailed extends ConfigurationState {
  final Error error;

  const ConfigFailed({required this.error}) : super();

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ConfigFailed{'
      'error: $error'
      '}';
}
