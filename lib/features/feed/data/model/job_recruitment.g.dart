// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'job_recruitment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$JobRecruitmentImpl _$$JobRecruitmentImplFromJson(Map<String, dynamic> json) =>
    _$JobRecruitmentImpl(
      company_name: json['company_name'] as String,
      job_position: json['job_position'] as String,
      job_location: json['job_location'] as String,
      job_type: json['job_type'] as String,
      about_the_oppotunity: json['about_the_oppotunity'] as String,
      role_responsibility: json['role_responsibility'] as String,
      skills: json['skills'] as String,
      years_of_experience: json['years_of_experience'] as String,
      sallary_range: json['sallary_range'] as String,
      recruiter_id: json['recruiter_id'] as String,
      created_at: DateTime.parse(json['created_at'] as String),
      candidates: (json['candidates'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$JobRecruitmentImplToJson(
        _$JobRecruitmentImpl instance) =>
    <String, dynamic>{
      'company_name': instance.company_name,
      'job_position': instance.job_position,
      'job_location': instance.job_location,
      'job_type': instance.job_type,
      'about_the_oppotunity': instance.about_the_oppotunity,
      'role_responsibility': instance.role_responsibility,
      'skills': instance.skills,
      'years_of_experience': instance.years_of_experience,
      'sallary_range': instance.sallary_range,
      'recruiter_id': instance.recruiter_id,
      'created_at': instance.created_at.toIso8601String(),
      'candidates': instance.candidates,
    };
