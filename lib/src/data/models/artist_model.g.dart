// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artist_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArtistDataModel _$ArtistDataModelFromJson(Map<String, dynamic> json) =>
    ArtistDataModel(
      id: json['artist_id'] as String,
      name: json['name'] as String,
      imageUrl: json['image_url'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      version: json['version'] as int,
    );

Map<String, dynamic> _$ArtistDataModelToJson(ArtistDataModel instance) =>
    <String, dynamic>{
      'artist_id': instance.id,
      'name': instance.name,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };
