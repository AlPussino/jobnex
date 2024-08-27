import 'package:freezed_annotation/freezed_annotation.dart';
part 'work_experience.freezed.dart';
part 'work_experience.g.dart';

@freezed
class WorkExperience with _$WorkExperience {
  const WorkExperience._();

  const factory WorkExperience({
    required String job_experience_id,
    required String job_position,
    required String job_location,
    required String company_name,
    required DateTime start_date,
    required DateTime stop_date,
    required bool still_working,
    required String job_type,
  }) = _WorkExperience;

  factory WorkExperience.fromJson(Map<String, Object> json) =>
      _$WorkExperienceFromJson(json);
}
