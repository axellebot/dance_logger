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
  PracticeRepository? _practiceRepository;
  FigureRepository? _figureRepository;
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
      await _appPrefsRepository?.saveFileDir(await _getDefaultFileDirPath());
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

        emit(state.copyWith(
          status: ConfigStatus.ready,
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
        emit(state.copyWith(
          status: ConfigStatus.notReady,
          appPrefsRepository: _appPrefsRepository!,
        ));
      }
    } on Error {
      emit(state.copyWith(
        status: ConfigStatus.failure,
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
