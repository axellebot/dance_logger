import 'package:dance/presentation.dart';
import 'package:quiver/core.dart';
import 'package:uuid/uuid.dart';

class MomentViewModel extends BaseViewModel {
  Duration startTime;
  Duration? endTime;
  String figureId;
  String videoId;

  MomentViewModel({
    required super.id,
    required this.startTime,
    this.endTime,
    required this.figureId,
    required this.videoId,
    required super.createdAt,
    required super.updatedAt,
    required super.version,
  });

  factory MomentViewModel.createNew({
    required Duration startTime,
    Duration? endTime,
    required String figureId,
    required String videoId,
  }) {
    return MomentViewModel(
      id: const Uuid().v4(),
      startTime: startTime,
      endTime: endTime,
      figureId: figureId,
      videoId: videoId,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      version: 1,
    );
  }

  MomentViewModel copyWith({
    String? id,
    Duration? startTime,
    Optional<Duration>? endTime,
    String? videoId,
    String? figureId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? version,
  }) {
    return MomentViewModel(
      id: id ?? this.id,
      startTime: startTime ?? this.startTime,
      endTime: endTime != null ? endTime.orNull : this.endTime,
      videoId: videoId ?? this.videoId,
      figureId: figureId ?? this.figureId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      version: version ?? this.version,
    );
  }

  @override
  String toString() => '$runtimeType{'
      'id: $id, '
      'startTime: $startTime, '
      'endTime: $endTime, '
      'figureId: $figureId, '
      'videoId: $videoId, '
      'createdAt: $createdAt, '
      'updatedAt: $updatedAt, '
      'version: $version'
      '}';
}
