// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticeDataModel _$PracticeDataModelFromJson(Map<String, dynamic> json) =>
    PracticeDataModel(
      id: json['practice_id'] as String,
      date: DateTime.parse(json['date'] as String),
      status: json['status'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      version: json['version'] as int,
    );

Map<String, dynamic> _$PracticeDataModelToJson(PracticeDataModel instance) =>
    <String, dynamic>{
      'practice_id': instance.id,
      'date': instance.date.toIso8601String(),
      'status': instance.status,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };
