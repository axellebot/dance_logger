import 'package:dance/src/domain/entities/dance_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'dance_model.g.dart';

@JsonSerializable()
class DanceDataModel implements DanceEntity {
  @override
  @JsonKey(name: 'dance_id')
  String id;

  @override
  @JsonKey(name: 'name')
  String name;

  @override
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @override
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @override
  @JsonKey(name: 'version')
  int version;

  DanceDataModel({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory DanceDataModel.fromJson(Map<String, dynamic> json) =>
      _$DanceDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$DanceDataModelToJson(this);
}
