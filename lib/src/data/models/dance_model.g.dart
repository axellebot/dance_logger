// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dance_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DanceDataModel _$DanceDataModelFromJson(Map<String, dynamic> json) =>
    DanceDataModel(
      id: json['dance_id'] as String,
      name: json['name'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      version: json['version'] as int,
    );

Map<String, dynamic> _$DanceDataModelToJson(DanceDataModel instance) =>
    <String, dynamic>{
      'dance_id': instance.id,
      'name': instance.name,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };
