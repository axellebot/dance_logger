import 'package:dance/domain.dart';
import 'package:equatable/equatable.dart';

enum ConfigStatus { initial, loading, notReady, ready, failure }

class ConfigState extends Equatable {
  final ConfigStatus status;

  final String? fileDir;
  final String? fileName;

  final AppPrefsRepository? appPrefsRepository;
  final DanceRepository? danceRepository;
  final ArtistRepository? artistRepository;
  final VideoRepository? videoRepository;
  final FigureRepository? figureRepository;
  final PracticeRepository? practiceRepository;

  final Error? error;

  const ConfigState({
    this.status = ConfigStatus.initial,
    this.fileDir,
    this.fileName,
    this.appPrefsRepository,
    this.danceRepository,
    this.artistRepository,
    this.videoRepository,
    this.figureRepository,
    this.practiceRepository,
    this.error,
  });

  @override
  List<Object?> get props => [
        status,
        fileDir,
        fileName,
        appPrefsRepository,
        artistRepository,
        danceRepository,
        figureRepository,
        practiceRepository,
        videoRepository,
        error,
      ];

  ConfigState copyWith({
    ConfigStatus? status,
    String? fileDir,
    String? fileName,
    AppPrefsRepository? appPrefsRepository,
    ArtistRepository? artistRepository,
    DanceRepository? danceRepository,
    FigureRepository? figureRepository,
    PracticeRepository? practiceRepository,
    VideoRepository? videoRepository,
    Error? error,
  }) {
    return ConfigState(
      status: status ?? this.status,
      fileDir: fileDir ?? this.fileDir,
      fileName: fileName ?? this.fileName,
      appPrefsRepository: appPrefsRepository ?? this.appPrefsRepository,
      artistRepository: artistRepository ?? this.artistRepository,
      danceRepository: danceRepository ?? this.danceRepository,
      figureRepository: figureRepository ?? this.figureRepository,
      practiceRepository: practiceRepository ?? this.practiceRepository,
      videoRepository: videoRepository ?? this.videoRepository,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'ConfigurationState{status: $status, fileDir: $fileDir, fileName: $fileName, appPrefsRepository: $appPrefsRepository, danceRepository: $danceRepository, artistRepository: $artistRepository, videoRepository: $videoRepository, figureRepository: $figureRepository, practiceRepository: $practiceRepository, error: $error}';
  }
}
