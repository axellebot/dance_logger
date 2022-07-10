import 'package:dance/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'video_model.g.dart';

@JsonSerializable()
class VideoDataModel implements VideoEntity {
  @override
  @JsonKey(name: 'video_id')
  String id;

  @override
  @JsonKey(name: 'name')
  String name;

  @override
  @JsonKey(name: 'url')
  String url;

  @override
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @override
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @override
  @JsonKey(name: 'version')
  int version;

  VideoDataModel({
    required this.id,
    required this.name,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory VideoDataModel.fromJson(Map<String, dynamic> json) =>
      _$VideoDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$VideoDataModelToJson(this);
}
