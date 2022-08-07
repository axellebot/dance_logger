// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MomentDataModel _$MomentDataModelFromJson(Map<String, dynamic> json) =>
    MomentDataModel(
      id: json['moment_id'] as String,
      videoId: json['video_id'] as String,
      startTime: json['start_time'] as int,
      endTime: json['end_time'] as int,
      figureId: json['figure_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      version: json['version'] as int,
    );

Map<String, dynamic> _$MomentDataModelToJson(MomentDataModel instance) =>
    <String, dynamic>{
      'moment_id': instance.id,
      'video_id': instance.videoId,
      'start_time': instance.startTime,
      'end_time': instance.endTime,
      'figure_id': instance.figureId,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'version': instance.version,
    };
