import 'package:dance/domain.dart';
import 'package:json_annotation/json_annotation.dart';

part 'figure_model.g.dart';

@JsonSerializable()
class FigureDataModel implements FigureEntity {
  @override
  @JsonKey(name: 'figure_id')
  String id;

  @override
  @JsonKey(name: 'name')
  String name;

  @override
  @JsonKey(name: 'advise')
  String? advise;

  @override
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @override
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @override
  @JsonKey(name: 'version')
  int version;

  FigureDataModel({
    required this.id,
    required this.name,
    this.advise,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory FigureDataModel.fromJson(Map<String, dynamic> json) =>
      _$FigureDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$FigureDataModelToJson(this);
}
