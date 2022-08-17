import 'package:dance/domain.dart';
import 'package:equatable/equatable.dart';

enum ConfigStatus { initial, loading, notReady, ready, failure }

class ConfigState extends Equatable {
  final ConfigStatus status;

  final String? fileDir;
  final String? fileName;

  final AppPrefsRepository? appPrefsRepository;
  final ArtistRepository? artistRepository;
  final DanceRepository? danceRepository;
  final FigureRepository? figureRepository;
  final MomentRepository? momentRepository;
  final PracticeRepository? practiceRepository;
  final VideoRepository? videoRepository;

  final Error? error;

  const ConfigState({
    this.status = ConfigStatus.initial,
    this.fileDir,
    this.fileName,
    this.appPrefsRepository,
    this.artistRepository,
    this.danceRepository,
    this.figureRepository,
    this.momentRepository,
    this.practiceRepository,
    this.videoRepository,
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
        momentRepository,
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
    MomentRepository? momentRepository,
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
      momentRepository: momentRepository ?? this.momentRepository,
      videoRepository: videoRepository ?? this.videoRepository,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'ConfigurationState{'
        'status: $status, '
        'fileDir: $fileDir, '
        'fileName: $fileName, '
        'appPrefsRepository: $appPrefsRepository, '
        'danceRepository: $danceRepository, '
        'artistRepository: $artistRepository, '
        'figureRepository: $figureRepository, '
        'momentRepository: $momentRepository, '
        'practiceRepository: $practiceRepository, '
        'videoRepository: $videoRepository, '
        'error: $error'
        '}';
  }
}
