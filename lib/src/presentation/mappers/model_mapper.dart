import 'package:dance/data.dart';
import 'package:dance/domain.dart';
import 'package:dance/presentation.dart';

/// [ModelMapper] for MVVM pattern
class ModelMapper {
  static ModelMapper? _instance;

  static _initState() {
    _instance = ModelMapper();
  }

  static ModelMapper get instance {
    return _instance ?? _initState();
  }

  /// [ArtistEntity] to [ArtistViewModel]
  ArtistViewModel toArtistViewModel(ArtistEntity entity) {
    return ArtistViewModel(
      id: entity.id,
      name: entity.name,
      imageUrl: entity.imageUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      version: entity.version,
    );
  }

  /// [ArtistViewModel] to [ArtistEntity]
  ArtistEntity toArtistEntity(ArtistViewModel viewModel) {
    return ArtistDataModel(
      id: viewModel.id,
      name: viewModel.name,
      imageUrl: viewModel.imageUrl,
      createdAt: viewModel.createdAt,
      updatedAt: viewModel.updatedAt,
      version: viewModel.version,
    );
  }

  /// [DanceEntity] to [DanceViewModel]
  DanceViewModel toDanceViewModel(DanceEntity entity) {
    return DanceViewModel(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      version: entity.version,
    );
  }

  /// [DanceViewModel] to [DanceEntity]
  DanceEntity toDanceEntity(DanceViewModel viewModel) {
    return DanceDataModel(
      id: viewModel.id,
      name: viewModel.name,
      createdAt: viewModel.createdAt,
      updatedAt: viewModel.updatedAt,
      version: viewModel.version,
    );
  }

  /// [FigureEntity] to [FigureViewModel]
  FigureViewModel toFigureViewModel(FigureEntity entity) {
    return FigureViewModel(
      id: entity.id,
      name: entity.name,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      version: entity.version,
    );
  }

  /// [PracticeEntity] to [PracticeViewModel]
  PracticeViewModel toPracticeViewModel(PracticeEntity entity) {
    return PracticeViewModel(
      id: entity.id,
      doneAt: entity.doneAt,
      status: entity.status,
      figureId: entity.figureId,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      version: entity.version,
    );
  }

  /// [MomentEntity] to [MomentViewModel]
  MomentViewModel toMomentViewModel(MomentEntity entity) {
    return MomentViewModel(
      id: entity.id,
      startTime: Duration(seconds: entity.startTime),
      endTime:
          entity.endTime != null ? Duration(seconds: entity.endTime!) : null,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      version: entity.version,
    );
  }

  /// [VideoEntity] to [VideoViewModel]
  VideoViewModel toVideoViewModel(VideoEntity entity) {
    return VideoViewModel(
      id: entity.id,
      name: entity.name,
      url: entity.url,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      version: entity.version,
    );
  }

  /// [VideoViewModel] to [VideoEntity]
  VideoEntity toVideoEntity(VideoViewModel viewModel) {
    return VideoDataModel(
      id: viewModel.id,
      name: viewModel.name,
      url: viewModel.url,
      createdAt: viewModel.createdAt,
      updatedAt: viewModel.updatedAt,
      version: viewModel.version,
    );
  }

  @override
  String toString() => '$runtimeType{}';
}
