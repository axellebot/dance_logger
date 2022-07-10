// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'figure_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FigureDataModel _$FigureDataModelFromJson(Map<String, dynamic> json) =>
    FigureDataModel(
      id: json['figure_id'] as String,
      name: json['name'] as String,
      advise: json['advise'] as String?,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      version: json['version'] as int,
    );

Map<String, dynamic> _$FigureDataModelToJson(FigureDataModel instance) =>
    <String, dynamic>{
      'figure_id': instance.id,
      'name': instance.name,
      'advise': instance.advise,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };
