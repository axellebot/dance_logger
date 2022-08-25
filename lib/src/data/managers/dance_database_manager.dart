import 'dart:async';
import 'dart:io';

import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DanceDatabaseManager
    implements
        ArtistDataStore,
        DanceDataStore,
        FigureDataStore,
        PracticeDataStore,
        VideoDataStore,
        MomentDataStore {
  final String filePath;
  late Database db;
  late final DatabaseFactory dbFactory;

  DanceDatabaseManager({
    required this.filePath,
  }) {
    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      // sqflite config
      dbFactory = databaseFactory;
    } else if (Platform.isWindows || Platform.isLinux) {
      // sqflite_ffi config
      sqfliteFfiInit(); // sqflite_ffi init
      dbFactory = databaseFactoryFfi; // sqflite_ffi factory
    }
  }

  FutureOr<void> open() async {
    db = await dbFactory.openDatabase(
      filePath,
      options: OpenDatabaseOptions(
        version: 1,
        onCreate: _onCreate,
        onConfigure: _onConfigure,
      ),
    );
  }

  FutureOr<void> close() async => await db.close();

  FutureOr<void> _onConfigure(Database db) {
    db.execute('PRAGMA foreign_keys = ON');
  }

  FutureOr<void> _onCreate(Database db, int version) {
    if (version == 1) {
      db.execute('''
        CREATE TABLE dances(
          dance_id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL
        )
      ''');
      db.execute('''
        CREATE TABLE figures(
          figure_id TEXT PRIMARY KEY,
          dance_id TEXT NOT NULL,
          name TEXT,
          description TEXT,
          advise TEXT,
          tags TEXT,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL,
          FOREIGN KEY (dance_id)
            REFERENCES dances (dance_id)
            ON DELETE SET NULL
        )
      ''');
      db.execute('''
        CREATE TABLE artists(
          artist_id TEXT PRIMARY KEY,
          name TEXT NOT NULL,
          image_url TEXT,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL
        )
      ''');
      db.execute('''
        CREATE TABLE videos(
          video_id TEXT PRIMARY KEY,
          name TEXT,
          url TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL
        )
      ''');
      db.execute('''
        CREATE TABLE practices(
          practice_id TEXT PRIMARY KEY,
          figure_id TEXT NOT NULL,
          comment TEXT,
          date TEXT NOT NULL,
          status TEXT,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL,
          FOREIGN KEY (figure_id)
            REFERENCES figures (figure_id)
            ON DELETE CASCADE
        )
      ''');
      db.execute('''
        CREATE TABLE users(
          user_id TEXT PRIMARY KEY,
          username TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL
        )
      ''');
      db.execute('''
        CREATE TABLE users_practices(
          user_id TEXT,
          practice_id TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL,
          FOREIGN KEY (user_id)
            REFERENCES users (user_id)
            ON DELETE SET NULL,
          FOREIGN KEY (practice_id)
            REFERENCES practices (practice_id)
            ON DELETE CASCADE
        )
      ''');
      db.execute('''
        CREATE TABLE moments(
          moment_id TEXT PRIMARY KEY,
          video_id TEXT NOT NULL,
          figure_id TEXT NOT NULL,
          start_time INTEGER NOT NULL,
          end_time INTEGER,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL,
          FOREIGN KEY (video_id)
            REFERENCES videos (video_id)
            ON DELETE CASCADE,
          FOREIGN KEY (figure_id)
            REFERENCES figures (figure_id)
            ON DELETE CASCADE 
        )
      ''');
      db.execute('''
        CREATE TABLE moments_artists(
          moment_id TEXT NOT NULL,
          artist_id TEXT NOT NULL,
          created_at TEXT NOT NULL,
          updated_at TEXT NOT NULL,
          version INTEGER NOT NULL,
          FOREIGN KEY (moment_id)
            REFERENCES moments (moment_id)
            ON DELETE CASCADE,
          FOREIGN KEY (artist_id)
            REFERENCES artists (artist_id)
            ON DELETE CASCADE
        )
      ''');
    }
  }

  FutureOr delete() async {
    if (kDebugMode) print('$runtimeType:delete()');
    await deleteDatabase(
      join(await getDatabasesPath(), filePath),
    );
  }

  /// --------------------------------------------------------------------------
  /// Artists
  /// --------------------------------------------------------------------------

  @override
  FutureOr<ArtistDataModel> saveArtist(ArtistDataModel artistModel) async {
    bool exists = true;
    try {
      await getArtist(artistModel.id);
    } on DataNotFoundError {
      exists = false;
    }

    int count;
    if (!exists) {
      count = await db.insert(
        'artists',
        artistModel.toJson(),
      );
      if (count == 0) throw DataNotCreatedError('Artist');
    } else {
      count = await db.update(
        'artists',
        artistModel.toJson(),
        where: 'artist_id = ?',
        whereArgs: [artistModel.id],
      );
      if (count == 0) throw DataNotUpdatedError('Artist');
    }
    return await getArtist(artistModel.id);
  }

  @override
  FutureOr<ArtistDataModel> getArtist(String artistId) async {
    if (kDebugMode) print('$runtimeType:getArtist($artistId)');

    List results = await db.query(
      'artists',
      where: 'artist_id = ?',
      whereArgs: [artistId],
      orderBy: 'name',
    );
    if (results.isEmpty) throw DataNotFoundError('Artist');
    ArtistDataModel artist = ArtistDataModel.fromJson(results.first);
    return artist;
  }

  @override
  FutureOr<void> deleteArtist(String artistId) async {
    if (kDebugMode) print('$runtimeType:deleteArtist($artistId)');

    await getArtist(artistId); // throw error if doesn't exist
    int count = await db.delete(
      'artists',
      where: 'artist_id= ?',
      whereArgs: [artistId],
    );
    if (count == 0) throw DataNotDeletedError('Artist');
  }

  @override
  FutureOr<List<ArtistDataModel>> getArtists({
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getArtists()');

    List results = await db.query(
      'artists',
      orderBy: 'name',
      limit: offset.limit,
      offset: offset.offset,
    );
    List<ArtistDataModel> artists =
        results.map((result) => ArtistDataModel.fromJson(result)).toList();
    return artists;
  }

  @override
  FutureOr<List<ArtistDataModel>> getArtistsOfSearch(
    String search, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfSearch($search)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT a.*
      FROM artists a
      WHERE a.name LIKE ?
      ORDER BY a.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        '%$search%',
        offset.limit,
        offset.offset,
      ],
    );
    List<ArtistDataModel> artists =
        results.map((result) => ArtistDataModel.fromJson(result)).toList();
    return artists;
  }

  @override
  FutureOr<List<ArtistDataModel>> getArtistsOfDance(
    String danceId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfDance($danceId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT a.*
      FROM artists a
        INNER JOIN moments_artists m_a
        ON a.artist_id = m_a.artist_id
          INNER JOIN moments m
          ON m_a.moment_id = m.moment_id
            INNER JOIN figures f
            ON m.figure_id = f.figure_id
      WHERE f.dance_id=?
      ORDER BY a.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        danceId,
        offset.limit,
        offset.offset,
      ],
    );
    List<ArtistDataModel> artists =
        results.map((result) => ArtistDataModel.fromJson(result)).toList();
    return artists;
  }

  @override
  FutureOr<List<ArtistDataModel>> getArtistsOfFigure(
    String figureId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfFigure($figureId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT a.*
      FROM artists a 
        INNER JOIN moments_artists m_a 
        ON a.artist_id = m_a.artist_id 
          INNER JOIN moments m 
          ON m_a.moment_id = m.moment_id
      WHERE m.figure_id = ?
      ORDER BY a.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        figureId,
        offset.limit,
        offset.offset,
      ],
    );
    List<ArtistDataModel> artists =
        results.map((result) => ArtistDataModel.fromJson(result)).toList();
    return artists;
  }

  @override
  FutureOr<List<ArtistDataModel>> getArtistsOfMoment(
    String momentId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfMoment($momentId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT a.*
      FROM artists a
        INNER JOIN moments_artists m_a
        ON a.artist_id = m_a.artist_id
      WHERE m_a.moment_id = ?
      ORDER BY a.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        momentId,
        offset.limit,
        offset.offset,
      ],
    );
    List<ArtistDataModel> artists =
        results.map((result) => ArtistDataModel.fromJson(result)).toList();
    return artists;
  }

  @override
  FutureOr<List<ArtistDataModel>> getArtistsOfVideo(
    String videoId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getArtistsOfVideo($videoId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT a.*
      FROM artists a
        INNER JOIN moments_artists m_a 
        ON a.artist_id=m_a.artist_id 
          INNER JOIN moments m 
          ON m_a.moment_id=m.moment_id
      WHERE m.video_id = ?
      ORDER BY a.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        videoId,
        offset.limit,
        offset.offset,
      ],
    );

    List<ArtistDataModel> artists =
        results.map((result) => ArtistDataModel.fromJson(result)).toList();
    return artists;
  }

  /// --------------------------------------------------------------------------
  /// Dance
  /// --------------------------------------------------------------------------

  @override
  FutureOr<DanceDataModel> saveDance(DanceDataModel danceModel) async {
    if (kDebugMode) print('$runtimeType:saveDance($danceModel)');

    bool exists = true;
    try {
      await getDance(danceModel.id);
    } on DataNotFoundError {
      exists = false;
    }

    int count;
    if (!exists) {
      count = await db.insert(
        'dances',
        danceModel.toJson(),
      );
      if (count == 0) throw DataNotCreatedError('Dance');
    } else {
      count = await db.update(
        'dances',
        danceModel.toJson(),
        where: 'dance_id = ?',
        whereArgs: [danceModel.id],
      );
      if (count == 0) throw DataNotUpdatedError('Dance');
    }
    return await getDance(danceModel.id);
  }

  @override
  FutureOr<DanceDataModel> getDance(String danceId) async {
    if (kDebugMode) print('$runtimeType:getDance($danceId)');

    List results = await db.query(
      'dances',
      where: 'dance_id = ?',
      whereArgs: [danceId],
      orderBy: 'name',
    );
    if (results.isEmpty) throw DataNotFoundError('Dance');
    DanceDataModel dance = DanceDataModel.fromJson(results.first);
    return dance;
  }

  @override
  FutureOr<void> deleteDance(String danceId) async {
    if (kDebugMode) print('$runtimeType:deleteDance($danceId)');

    await getDance(danceId); // throw error if doesn't exist
    int count = await db.delete(
      'dances',
      where: 'dance_id= ?',
      whereArgs: [danceId],
    );
    if (count == 0) throw DataNotDeletedError('Dance');
  }

  @override
  FutureOr<List<DanceDataModel>> getDances({
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getDances()');

    List results = await db.query(
      'dances',
      orderBy: 'name',
      limit: offset.limit,
      offset: offset.offset,
    );
    List<DanceDataModel> dances =
        results.map((result) => DanceDataModel.fromJson(result)).toList();
    return dances;
  }

  @override
  FutureOr<List<DanceDataModel>> getDancesOfSearch(
    String search, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getDancesOfSearch($search)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT d.*
      FROM dances d
      WHERE d.name LIKE ?
      ORDER BY d.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        '%$search%',
        offset.limit,
        offset.offset,
      ],
    );
    List<DanceDataModel> dances =
        results.map((result) => DanceDataModel.fromJson(result)).toList();
    return dances;
  }

  @override
  FutureOr<List<DanceDataModel>> getDancesOfArtist(
    String artistId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getDancesOfArtist($artistId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT d.*
      FROM dances d
        INNER JOIN figures f
        ON d.dance_id = f.dance_id
          INNER JOIN moments m
          ON f.figure_id = m.figure_id 
            INNER JOIN moments_artists m_a
            ON m.moment_id = m_a.moment_id
      WHERE m_a.artist_id = ?
      ORDER BY d.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        artistId,
        offset.limit,
        offset.offset,
      ],
    );
    List<DanceDataModel> dances =
        results.map((result) => DanceDataModel.fromJson(result)).toList();
    return dances;
  }

  @override
  FutureOr<List<DanceDataModel>> getDancesOfVideo(
    String videoId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getDancesOfVideo($videoId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT d.*
      FROM dances d
        INNER JOIN figures f
        ON d.dance_id = f.dance_id
          INNER JOIN moments m
          ON f.figure_id = m.figure_id 
      WHERE m.video_id = ?
      ORDER BY d.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        videoId,
        offset.limit,
        offset.offset,
      ],
    );
    List<DanceDataModel> dances =
        results.map((result) => DanceDataModel.fromJson(result)).toList();
    return dances;
  }

  /// --------------------------------------------------------------------------
  /// Figures
  /// --------------------------------------------------------------------------

  @override
  FutureOr<FigureDataModel> saveFigure(FigureDataModel figureModel) async {
    if (kDebugMode) print('$runtimeType:saveFigure($figureModel)');

    bool exists = true;
    try {
      await getDance(figureModel.id);
    } on DataNotFoundError {
      exists = false;
    }

    int count;
    if (!exists) {
      count = await db.insert(
        'figures',
        figureModel.toJson(),
      );
      if (count == 0) throw DataNotCreatedError('Figure');
    } else {
      count = await db.update(
        'figures',
        figureModel.toJson(),
        where: 'figure_id = ?',
        whereArgs: [figureModel.id],
      );
      if (count == 0) throw DataNotUpdatedError('Figure');
    }
    return await getFigure(figureModel.id);
  }

  @override
  FutureOr<FigureDataModel> getFigure(String figureId) async {
    if (kDebugMode) print('$runtimeType:getFigure($figureId)');

    List results = await db.query(
      'figures',
      where: 'figure_id = ?',
      whereArgs: [figureId],
      orderBy: 'name',
    );
    if (results.isEmpty) throw DataNotFoundError('Figure');
    FigureDataModel figure = FigureDataModel.fromJson(results.first);
    return figure;
  }

  @override
  FutureOr<void> deleteFigure(String figureId) async {
    if (kDebugMode) print('$runtimeType:deleteFigure($figureId)');

    await getFigure(figureId); // throw error if doesn't exist
    int count = await db.delete(
      'figures',
      where: 'figure_id= ?',
      whereArgs: [figureId],
    );
    if (count == 0) throw DataNotDeletedError('Figure');
  }

  @override
  FutureOr<List<FigureDataModel>> getFigures({
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getFigures()');

    List results = await db.query(
      'figures',
      orderBy: 'name',
      limit: offset.limit,
      offset: offset.offset,
    );
    List<FigureDataModel> figures =
        results.map((result) => FigureDataModel.fromJson(result)).toList();
    return figures;
  }

  @override
  FutureOr<List<FigureDataModel>> getFiguresOfArtist(
    String artistId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getFiguresOfArtist($artistId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT f.*
      FROM figures f
        INNER JOIN moments m
        ON f.figure_id = m.figure_id
          INNER JOIN moments_artists m_a
          ON m.moment_id = m_a.moment_id
      WHERE m_a.artist_id = ?
      ORDER BY f.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        artistId,
        offset.limit,
        offset.offset,
      ],
    );
    List<FigureDataModel> figures =
        results.map((result) => FigureDataModel.fromJson(result)).toList();
    return figures;
  }

  @override
  FutureOr<List<FigureDataModel>> getFiguresOfDance(
    String danceId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getFiguresOfDance($danceId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT f.*
      FROM figures f
      WHERE f.dance_id = ?
      ORDER BY f.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        danceId,
        offset.limit,
        offset.offset,
      ],
    );
    List<FigureDataModel> figures =
        results.map((result) => FigureDataModel.fromJson(result)).toList();
    return figures;
  }

  @override
  FutureOr<List<FigureDataModel>> getFiguresOfVideo(
    String videoId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getFiguresOfVideo($videoId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT f.*
      FROM figures f
        INNER JOIN moments m
        ON f.figure_id = m.figure_id
      WHERE m.video_id = ?
      ORDER BY f.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        videoId,
        offset.limit,
        offset.offset,
      ],
    );
    List<FigureDataModel> figures =
        results.map((result) => FigureDataModel.fromJson(result)).toList();
    return figures;
  }

  /// --------------------------------------------------------------------------
  /// Moments
  /// --------------------------------------------------------------------------

  @override
  FutureOr<MomentDataModel> saveMoment(MomentDataModel momentModel) async {
    if (kDebugMode) print('$runtimeType:saveMoment($momentModel)');

    bool exists = true;
    try {
      await getDance(momentModel.id);
    } on DataNotFoundError {
      exists = false;
    }

    int count;
    if (!exists) {
      count = await db.insert(
        'moments',
        momentModel.toJson(),
      );
      if (count == 0) throw DataNotCreatedError('Moment');
    } else {
      count = await db.update(
        'moments',
        momentModel.toJson(),
        where: 'moment_id = ?',
        whereArgs: [momentModel.id],
      );
      if (count == 0) throw DataNotUpdatedError('Moment');
    }
    return await getMoment(momentModel.id);
  }

  @override
  FutureOr<MomentDataModel> getMoment(String momentId) async {
    if (kDebugMode) print('$runtimeType:getMoment($momentId)');

    List results = await db.query(
      'moments',
      where: 'moment_id = ?',
      whereArgs: [momentId],
      orderBy: 'start_time',
    );
    if (results.isEmpty) throw DataNotFoundError('Moment');
    MomentDataModel moment = MomentDataModel.fromJson(results.first);
    return moment;
  }

  @override
  FutureOr<void> deleteMoment(String momentId) async {
    if (kDebugMode) print('$runtimeType:deleteMoment($momentId)');

    await getMoment(momentId); // throw error if doesn't exist
    int count = await db.delete(
      'moments',
      where: 'moment_id = ?',
      whereArgs: [momentId],
    );
    if (count == 0) throw DataNotDeletedError('Moment');
  }

  @override
  FutureOr<List<MomentDataModel>> getMoments({
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getMoments()');

    List results = await db.query(
      'moments',
      orderBy: 'start_time',
      limit: offset.limit,
      offset: offset.offset,
    );

    List<MomentDataModel> moments =
        results.map((result) => MomentDataModel.fromJson(result)).toList();
    return moments;
  }

  @override
  FutureOr<List<MomentDataModel>> getMomentsOfFigure(
    String figureId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getMomentsOfFigure($figureId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT m.*
      FROM moments m
      WHERE m.figure_id = ?
      ORDER BY m.start_time
      LIMIT ?
      OFFSET ?
    ''',
      [
        figureId,
        offset.limit,
        offset.offset,
      ],
    );
    List<MomentDataModel> moments =
        results.map((result) => MomentDataModel.fromJson(result)).toList();
    return moments;
  }

  @override
  FutureOr<List<MomentDataModel>> getMomentsOfVideo(
    String videoId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getMomentsOfVideo($videoId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT m.*
      FROM moments m
      WHERE m.video_id = ?
      ORDER BY m.start_time
      LIMIT ?
      OFFSET ?
    ''',
      [
        videoId,
        offset.limit,
        offset.offset,
      ],
    );

    List<MomentDataModel> moments =
        results.map((result) => MomentDataModel.fromJson(result)).toList();
    return moments;
  }

  @override
  FutureOr<List<MomentDataModel>> getMomentsOfArtist(
    String artistId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getMomentsOfArtist($artistId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT m.*
      FROM moments m
        INNER JOIN moments_artists m_a
        ON m.moment_id = m_a.moment_id
      WHERE m_a.artist_id = ?
      ORDER BY m.start_time
      LIMIT ?
      OFFSET ?
    ''',
      [
        artistId,
        offset.limit,
        offset.offset,
      ],
    );
    List<MomentDataModel> moments =
        results.map((result) => MomentDataModel.fromJson(result)).toList();
    return moments;
  }

  /// --------------------------------------------------------------------------
  /// Practices
  /// --------------------------------------------------------------------------

  @override
  FutureOr<PracticeDataModel> savePractice(
      PracticeDataModel practiceModel) async {
    bool exists = true;
    if (kDebugMode) print('$runtimeType:savePractice($practiceModel)');

    try {
      await getPractice(practiceModel.id);
    } on DataNotFoundError {
      exists = false;
    }

    int count;
    if (!exists) {
      count = await db.insert(
        'practices',
        practiceModel.toJson(),
      );
      if (count == 0) throw DataNotCreatedError('Practice');
    } else {
      count = await db.update(
        'practices',
        practiceModel.toJson(),
        where: 'practice_id = ?',
        whereArgs: [practiceModel.id],
      );
      if (count == 0) throw DataNotUpdatedError('Practice');
    }
    return await getPractice(practiceModel.id);
  }

  @override
  FutureOr<PracticeDataModel> getPractice(String practiceId) async {
    if (kDebugMode) print('$runtimeType:getPractice($practiceId)');

    List results = await db.query(
      'practices',
      where: 'practice_id = ?',
      whereArgs: [practiceId],
      orderBy: 'date',
    );
    if (results.isEmpty) throw DataNotFoundError('Figure');
    PracticeDataModel practice = PracticeDataModel.fromJson(results.first);
    return practice;
  }

  @override
  FutureOr<void> deletePractice(String practiceId) async {
    if (kDebugMode) print('$runtimeType:deletePractice($practiceId)');

    await getPractice(practiceId); // throw error if doesn't exist
    int count = await db.delete(
      'practices',
      where: 'practice_id = ?',
      whereArgs: [practiceId],
    );
    if (count == 0) throw DataNotDeletedError('Practice');
  }

  @override
  FutureOr<List<PracticeDataModel>> getPractices({
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getPractices()');

    List results = await db.query(
      'practices',
      orderBy: 'date',
      limit: offset.limit,
      offset: offset.offset,
    );
    List<PracticeDataModel> practices =
        results.map((result) => PracticeDataModel.fromJson(result)).toList();
    return practices;
  }

  @override
  FutureOr<List<PracticeDataModel>> getPracticesOfFigure(
    String figureId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getPracticesOfFigure($figureId)');
    // TODO: implement getPracticesOfFigure
    throw UnimplementedError();
  }

  @override
  FutureOr<List<PracticeDataModel>> getPracticesOfUser(
    String userId, {
    required Offset offset,
  }) async {
    // TODO: implement getPracticesOfUser
    throw UnimplementedError();
  }

  /// --------------------------------------------------------------------------
  /// Videos
  /// --------------------------------------------------------------------------

  @override
  FutureOr<VideoDataModel> saveVideo(VideoDataModel videoModel) async {
    bool exists = true;
    try {
      await getVideo(videoModel.id);
    } on DataNotFoundError {
      exists = false;
    }

    int count;
    if (!exists) {
      count = await db.insert(
        'videos',
        videoModel.toJson(),
      );
      if (count == 0) throw DataNotCreatedError('Video');
    } else {
      count = await db.update(
        'videos',
        videoModel.toJson(),
        where: 'video_id = ?',
        whereArgs: [videoModel.id],
      );
      if (count == 0) throw DataNotUpdatedError('Video');
    }
    return await getVideo(videoModel.id);
  }

  @override
  FutureOr<VideoDataModel> getVideo(String videoId) async {
    if (kDebugMode) print('$runtimeType:getVideo($videoId)');

    List results = await db.query(
      'videos',
      where: 'video_id = ?',
      whereArgs: [videoId],
      orderBy: 'name',
    );
    if (results.isEmpty) throw DataNotFoundError('Video');
    VideoDataModel video = VideoDataModel.fromJson(results.first);
    return video;
  }

  @override
  FutureOr<void> deleteVideo(String videoId) async {
    if (kDebugMode) print('$runtimeType:deleteVideo($videoId)');

    await getVideo(videoId); // throw error if doesn't exist
    int count = await db.delete(
      'videos',
      where: 'video_id= ?',
      whereArgs: [videoId],
    );
    if (count == 0) throw DataNotDeletedError('Video');
  }

  @override
  FutureOr<List<VideoDataModel>> getVideos({
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getVideos()');
    List results = await db.query(
      'videos',
      orderBy: 'name',
      limit: offset.limit,
      offset: offset.offset,
    );
    List<VideoDataModel> videos =
        results.map((result) => VideoDataModel.fromJson(result)).toList();
    return videos;
  }

  @override
  FutureOr<List<VideoDataModel>> getVideosOfSearch(
    String search, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfSearch($search)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT v.*
      FROM videos v
      WHERE v.name LIKE ?
      ORDER BY v.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        '%$search%',
        offset.limit,
        offset.offset,
      ],
    );

    List<VideoDataModel> videos =
        results.map((result) => VideoDataModel.fromJson(result)).toList();
    return videos;
  }

  @override
  FutureOr<List<VideoDataModel>> getVideosOfArtist(
    String artistId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfArtist($artistId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT v.*
      FROM videos v
        INNER JOIN moments m
        ON v.video_id = m.video_id
          INNER JOIN moments_artists m_a
          ON m.moment_id = m_a.moment_id
      WHERE m_a.artist_id = ?
      ORDER BY v.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        artistId,
        offset.limit,
        offset.offset,
      ],
    );

    List<VideoDataModel> videos =
        results.map((result) => VideoDataModel.fromJson(result)).toList();
    return videos;
  }

  @override
  FutureOr<List<VideoDataModel>> getVideosOfDance(
    String danceId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfDance($danceId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT v.*
      FROM videos v
        INNER JOIN moments m
        ON v.video_id = m.video_id
          INNER JOIN figures f
          ON f.figure_id = m.figure_id
      WHERE f.dance_id = ?
      ORDER BY v.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        danceId,
        offset.limit,
        offset.offset,
      ],
    );

    List<VideoDataModel> videos =
        results.map((result) => VideoDataModel.fromJson(result)).toList();
    return videos;
  }

  @override
  FutureOr<List<VideoDataModel>> getVideosOfFigure(
    String figureId, {
    required Offset offset,
  }) async {
    if (kDebugMode) print('$runtimeType:getVideosOfFigure($figureId)');

    List results = await db.rawQuery(
      '''
      SELECT DISTINCT v.*
      FROM videos v
        INNER JOIN moments m
        ON v.video_id = m.video_id
      WHERE m.figure_id = ?
      ORDER BY v.name
      LIMIT ?
      OFFSET ?
    ''',
      [
        figureId,
        offset.limit,
        offset.offset,
      ],
    );

    List<VideoDataModel> videos =
        results.map((result) => VideoDataModel.fromJson(result)).toList();
    return videos;
  }
}
