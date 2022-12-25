import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dance/bloc.dart';
import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:dance/src/data/repositories/dance_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigState> {
  /// Managers
  DanceDatabaseManager? danceDatabaseManager;

  /// Repositories
  AppPrefsRepository? _appPrefsRepository;

  DanceRepository? _danceRepository;
  ArtistRepository? _artistRepository;
  FigureRepository? _figureRepository;
  MomentRepository? _momentRepository;
  PracticeRepository? _practiceRepository;
  VideoRepository? _videoRepository;

  ConfigurationBloc() : super(const ConfigState()) {
    // App Prefs
    final AppPrefsDataStore diskAppPrefsDataStore = AppPrefsManager();
    final AppPrefsDataStoreFactory appPrefsDataStoreFactory =
        AppPrefsDataStoreFactory(diskDataStore: diskAppPrefsDataStore);
    _appPrefsRepository =
        ImplAppPrefsRepository(factory: appPrefsDataStoreFactory);

    on<ConfigLoad>(_onConfigLoad);
    on<ConfigChange>(_onConfigChange);
  }

  FutureOr<void> _onConfigLoad(
    ConfigLoad event,
    Emitter<ConfigState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onConfigLoad');

    try {
      emit(state.copyWith(
        status: ConfigStatus.loading,
      ));
      await _loadConfig(emit);
    } on Error catch (error) {
      emit(state.copyWith(
        status: ConfigStatus.failure,
        error: error,
      ));
    }
  }

  FutureOr<void> _onConfigChange(
    ConfigChange event,
    Emitter<ConfigState> emit,
  ) async {
    if (kDebugMode) print('$runtimeType:_onConfigChange');

    try {
      emit(state.copyWith(
        status: ConfigStatus.loading,
      ));
      await danceDatabaseManager?.close();

      /// Set fileDir
      event.fileDir != null
          ? await  _appPrefsRepository?.saveFileDir(event.fileDir!)
          : await _appPrefsRepository?.deleteFileName();
      /// Set fileName
      event.fileName != null
          ? await _appPrefsRepository?.saveFileName(event.fileName!)
          : await _appPrefsRepository?.deleteFileName();

      await _loadConfig(emit);
    } on Error catch (error) {
      emit(state.copyWith(
        status: ConfigStatus.failure,
        error: error,
      ));
    }
  }

  Future<String> _getDefaultFileDirPath() async =>
      (await getApplicationDocumentsDirectory()).path;

  Future<void> _loadConfig(Emitter<ConfigState> emit) async {
    if (kDebugMode) print('$runtimeType:_loadConfig');

    try {
      String? fileDirPath = await _appPrefsRepository?.getFileDir()?? await _getDefaultFileDirPath();
      String? fileName = await _appPrefsRepository?.getFileName() ?? 'dance_logger.db';

      String filePath = join(
        fileDirPath ,
        fileName,
      );

      // Database manager
      await danceDatabaseManager?.close();
      danceDatabaseManager = DanceDatabaseManager(
        filePath: filePath,
      );
      await danceDatabaseManager!.open();

      // Data Stores
      final DanceDataStore databaseDanceDataStore = danceDatabaseManager!;
      final ArtistDataStore databaseArtistDataStore = danceDatabaseManager!;
      final FigureDataStore databaseFigureDataStore = danceDatabaseManager!;
      final MomentDataStore databaseMomentDataStore = danceDatabaseManager!;
      final PracticeDataStore databasePracticeDataStore = danceDatabaseManager!;
      final VideoDataStore databaseVideoDataStore = danceDatabaseManager!;

      // Data Store Factories
      final artistDataStoreFactory = ArtistDataStoreFactory(
        databaseDataStore: databaseArtistDataStore,
      );
      final danceDataStoreFactory = DanceDataStoreFactory(
        databaseDataStore: databaseDanceDataStore,
      );
      final figureDataStoreFactory = FigureDataStoreFactory(
        databaseDataStore: databaseFigureDataStore,
      );
      final momentDataStoreFactory = MomentDataStoreFactory(
        databaseDataStore: databaseMomentDataStore,
      );
      final practiceDataStoreFactory = PracticeDataStoreFactory(
        databaseDataStore: databasePracticeDataStore,
      );
      final videoDataStoreFactory = VideoDataStoreFactory(
        databaseDataStore: databaseVideoDataStore,
      );

      // Repositories
      _artistRepository = ImplArtistRepository(
        factory: artistDataStoreFactory,
      );
      _danceRepository = ImplDanceRepository(
        factory: danceDataStoreFactory,
      );
      _figureRepository = ImplFigureRepository(
        factory: figureDataStoreFactory,
      );
      _momentRepository = ImplMomentRepository(
        factory: momentDataStoreFactory,
      );
      _practiceRepository = ImplPracticeRepository(
        factory: practiceDataStoreFactory,
      );
      _videoRepository = ImplVideoRepository(
        factory: videoDataStoreFactory,
      );

      emit(state.copyWith(
        status: ConfigStatus.ready,
        fileDir: fileDirPath,
        fileName: fileName,
        appPrefsRepository: _appPrefsRepository!,
        artistRepository: _artistRepository!,
        danceRepository: _danceRepository!,
        figureRepository: _figureRepository!,
        momentRepository: _momentRepository!,
        practiceRepository: _practiceRepository!,
        videoRepository: _videoRepository!,
      ));
    } on Error catch (error) {
      emit(state.copyWith(
        status: ConfigStatus.failure,
        error: error,
      ));
    }
  }

  @override
  Future<void> close() async {
    if (kDebugMode) print('$runtimeType:close()');
    await danceDatabaseManager?.close();
    return super.close();
  }
}
