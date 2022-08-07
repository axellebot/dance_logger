import 'package:dance/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'moment_model.g.dart';

@JsonSerializable()
class MomentDataModel implements MomentEntity {
  @override
  @JsonKey(name: 'moment_id')
  String id;

  @override
  @JsonKey(name: 'video_id')
  String videoId;

  @override
  @JsonKey(name: 'start_time')
  int startTime;

  @override
  @JsonKey(name: 'end_time')
  int endTime;

  @override
  @JsonKey(name: 'figure_id')
  String figureId;

  @override
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @override
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @override
  @JsonKey(name: 'version')
  int version;

  MomentDataModel({
    required this.id,
    required this.videoId,
    required this.startTime,
    required this.endTime,
    required this.figureId,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory MomentDataModel.fromJson(Map<String, dynamic> json) =>
      _$MomentDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$MomentDataModelToJson(this);
}
