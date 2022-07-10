import 'package:dance/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'practice_model.g.dart';

@JsonSerializable()
class PracticeDataModel implements PracticeEntity {
  @override
  @JsonKey(name: 'practice_id')
  String id;

  @override
  @JsonKey(name: 'date')
  DateTime date;

  @override
  @JsonKey(name: 'status')
  String status;

  @override
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @override
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @override
  @JsonKey(name: 'version')
  int version;

  PracticeDataModel({
    required this.id,
    required this.date,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory PracticeDataModel.fromJson(Map<String, dynamic> json) =>
      _$PracticeDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$PracticeDataModelToJson(this);
}
