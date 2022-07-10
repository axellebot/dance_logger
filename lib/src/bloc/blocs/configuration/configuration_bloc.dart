import 'package:bloc/bloc.dart';
import 'package:dance/bloc.dart';
import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:dance/src/data/repositories/dance_repository.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final String _tag = '$ConfigurationBloc';

  /// Managers
  DanceDatabaseManager? danceDatabaseManager;

  /// Repositories
  AppPrefsRepository? _appPrefsRepository;

  DanceRepository? _danceRepository;
  ArtistRepository? _artistRepository;
  PracticeRepository? _practiceRepository;
  FigureRepository? _figureRepository;
  VideoRepository? _videoRepository;

  ConfigurationBloc() : super(ConfigLoading()) {
    // App Prefs
    final AppPrefsDataStore diskAppPrefsDataStore = AppPrefsManager();
    final AppPrefsDataStoreFactory appPrefsDataStoreFactory =
        AppPrefsDataStoreFactory(diskDataStore: diskAppPrefsDataStore);
    _appPrefsRepository =
        ImplAppPrefsRepository(factory: appPrefsDataStoreFactory);

    on<ConfigChange>((event, emit) async {
      emit(ConfigLoading());
      await _appPrefsRepository?.setFileDir(await _getDefaultFileDirPath());
      event.fileName != null
          ? await _appPrefsRepository?.setFileName(event.fileName!)
          : await _appPrefsRepository?.deleteFileName();

      await _loadConfig(emit);
    });
    on<ConfigLoad>((event, emit) async {
      emit(ConfigLoading());
      await _loadConfig(emit);
    });
  }

  Future<String> _getDefaultFileDirPath() async =>
      (await getApplicationDocumentsDirectory()).path;

  Future<void> _loadConfig(Emitter<ConfigurationState> emit) async {
    try {
      String? fileDirPath = await _appPrefsRepository?.getFileDir();
      String? fileName = await _appPrefsRepository?.getFileName();

      if (fileDirPath != null && fileName != null) {
        String filePath = join(fileDirPath, fileName);

        // Database manager
        await danceDatabaseManager?.close();
        danceDatabaseManager = DanceDatabaseManager(
          filePath: filePath,
        );
        await danceDatabaseManager!.open();

        // Data Stores
        final DanceDataStore databaseDanceDataStore = danceDatabaseManager!;
        final ArtistDataStore databaseArtistDataStore = danceDatabaseManager!;
        final VideoDataStore databaseVideoDataStore = danceDatabaseManager!;
        final FigureDataStore databaseFigureDataStore = danceDatabaseManager!;
        final PracticeDataStore databasePracticeDataStore =
            danceDatabaseManager!;

        // Data Store Factories
        final danceDataStoreFactory = DanceDataStoreFactory(
          databaseDataStore: databaseDanceDataStore,
        );
        final artistDataStoreFactory = ArtistDataStoreFactory(
          databaseDataStore: databaseArtistDataStore,
        );
        final videoDataStoreFactory = VideoDataStoreFactory(
          databaseDataStore: databaseVideoDataStore,
        );
        final figureDataStoreFactory = FigureDataStoreFactory(
          databaseDataStore: databaseFigureDataStore,
        );
        final practiceDataStoreFactory = PracticeDataStoreFactory(
          databaseDataStore: databasePracticeDataStore,
        );

        // Repositories
        _danceRepository = ImplDanceRepository(
          factory: danceDataStoreFactory,
        );
        _artistRepository = ImplArtistRepository(
          factory: artistDataStoreFactory,
        );
        _videoRepository = ImplVideoRepository(
          factory: videoDataStoreFactory,
        );
        _practiceRepository = ImplPracticeRepository(
          factory: practiceDataStoreFactory,
        );
        _figureRepository = ImplFigureRepository(
          factory: figureDataStoreFactory,
        );

        emit(ConfigLoaded(
          fileDir: fileDirPath,
          fileName: fileName,
          appPrefsRepository: _appPrefsRepository!,
          danceRepository: _danceRepository!,
          artistRepository: _artistRepository!,
          videoRepository: _videoRepository!,
          figureRepository: _figureRepository!,
          practiceRepository: _practiceRepository!,
        ));
      } else {
        emit(ConfigNotLoaded(
          appPrefsRepository: _appPrefsRepository!,
        ));
      }
    } catch (error, stacktrace) {
      addError(error, stacktrace);
    }
  }

  @override
  Future<void> close() async {
    await danceDatabaseManager?.close();
    return super.close();
  }
}
