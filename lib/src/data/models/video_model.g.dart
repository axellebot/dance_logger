// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VideoDataModel _$VideoDataModelFromJson(Map<String, dynamic> json) =>
    VideoDataModel(
      id: json['video_id'] as String,
      name: json['name'] as String,
      url: json['url'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      version: json['version'] as int,
    );

Map<String, dynamic> _$VideoDataModelToJson(VideoDataModel instance) =>
    <String, dynamic>{
      'video_id': instance.id,
      'name': instance.name,
      'url': instance.url,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };
