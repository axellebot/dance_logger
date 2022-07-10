import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';

/// [ModelMapper] for MVVM pattern
class ModelMapper {
  final String _tag = '$ModelMapper';

  static ModelMapper? _instance;

  static _initState() {
    _instance = ModelMapper();
  }

  static ModelMapper get instance {
    return _instance ?? _initState();
  }

  /// [ArtistDataModel] to [ArtistViewModel]
  ArtistViewModel toArtistViewModel(ArtistEntity dataModel) {
    return ArtistViewModel(
      id: dataModel.id,
      name: dataModel.name,
      imageUrl: dataModel.imageUrl,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [DanceDataModel] to [DanceViewModel]
  DanceViewModel toDanceViewModel(DanceEntity dataModel) {
    return DanceViewModel(
      id: dataModel.id,
      name: dataModel.name,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [FigureEntity] to [FigureViewModel]
  FigureViewModel toFigureViewModel(FigureEntity dataModel) {
    return FigureViewModel(
      id: dataModel.id,
      name: dataModel.name,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [PracticeEntity] to [PracticeViewModel]
  PracticeViewModel toPracticeViewModel(PracticeEntity dataModel) {
    return PracticeViewModel(
      id: dataModel.id,
      status: dataModel.status,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [TimeEntity] to [TimeViewModel]
  TimeViewModel toTimeViewModel(TimeEntity dataModel) {
    return TimeViewModel(
      id: dataModel.id,
      startTime: dataModel.startTime,
      endTime: dataModel.endTime,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  /// [VideoEntity] to [VideoViewModel]
  VideoViewModel toVideoViewModel(VideoEntity dataModel) {
    return VideoViewModel(
      id: dataModel.id,
      name: dataModel.name,
      url: dataModel.url,
      createdAt: dataModel.createdAt,
      updatedAt: dataModel.updatedAt,
      version: dataModel.version,
    );
  }

  @override
  String toString() => '$runtimeType{}';
}
