import 'package:dance/src/domain/entities/artist_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'artist_model.g.dart';

@JsonSerializable()
class ArtistDataModel implements ArtistEntity {
  @override
  @JsonKey(name: 'artist_id')
  String id;

  @override
  @JsonKey(name: 'name')
  String name;

  @override
  @JsonKey(name: 'image_url')
  String? imageUrl;

  @override
  @JsonKey(name: 'created_at')
  DateTime createdAt;

  @override
  @JsonKey(name: 'updated_at')
  DateTime updatedAt;

  @override
  @JsonKey(name: 'version')
  int version;

  ArtistDataModel({
    required this.id,
    required this.name,
    this.imageUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.version,
  });

  factory ArtistDataModel.fromJson(Map<String, dynamic> json) =>
      _$ArtistDataModelFromJson(json);

  Map<String, dynamic> toJson() => _$ArtistDataModelToJson(this);
}
