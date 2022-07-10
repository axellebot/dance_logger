import 'package:dance/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'time_model.g.dart';

@JsonSerializable()
class TimeDataModel implements TimeEntity {
  @override
  @JsonKey(name: 'timecode_id')
  String id;

  @override
  @JsonKey(name: 'start_time')
  String startTime;

  @override
  @JsonKey(name: 'end_time')
  String endTime;

  @override
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @override
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @override
  @JsonKey(name: 'version')
  int version;

  TimeDataModel({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory TimeDataModel.fromJson(Map<String, dynamic> json) =>
      _$TimeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$TimeDataModelToJson(this);
}
