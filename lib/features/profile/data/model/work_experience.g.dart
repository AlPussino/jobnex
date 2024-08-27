// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_experience.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkExperienceImpl _$$WorkExperienceImplFromJson(Map<String, dynamic> json) =>
    _$WorkExperienceImpl(
      job_experience_id: json['job_experience_id'] as String,
      job_position: json['job_position'] as String,
      job_location: json['job_location'] as String,
      company_name: json['company_name'] as String,
      start_date: DateTime.parse(json['start_date'] as String),
      stop_date: DateTime.parse(json['stop_date'] as String),
      still_working: json['still_working'] as bool,
      job_type: json['job_type'] as String,
    );

Map<String, dynamic> _$$WorkExperienceImplToJson(
        _$WorkExperienceImpl instance) =>
    <String, dynamic>{
      'job_experience_id': instance.job_experience_id,
      'job_position': instance.job_position,
      'job_location': instance.job_location,
      'company_name': instance.company_name,
      'start_date': instance.start_date.toIso8601String(),
      'stop_date': instance.stop_date.toIso8601String(),
      'still_working': instance.still_working,
      'job_type': instance.job_type,
    };
