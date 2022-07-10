// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'time_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TimeDataModel _$TimeDataModelFromJson(Map<String, dynamic> json) =>
    TimeDataModel(
      id: json['timecode_id'] as String,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      version: json['version'] as int,
    );

Map<String, dynamic> _$TimeDataModelToJson(TimeDataModel instance) =>
    <String, dynamic>{
      'timecode_id': instance.id,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };
