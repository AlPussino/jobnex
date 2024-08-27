import 'package:freezed_annotation/freezed_annotation.dart';
part 'job_recruitment.freezed.dart';
part 'job_recruitment.g.dart';

@freezed
class JobRecruitment with _$JobRecruitment {
  const JobRecruitment._();

  const factory JobRecruitment({
    required String company_name,
    required String job_position,
    required String job_location,
    required String job_type,
    required String about_the_oppotunity,
    required String role_responsibility,
    required String skills,
    required String years_of_experience,
    required String sallary_range,
    required String recruiter_id,
    required DateTime created_at,
    required List<String> candidates,
  }) = _JobRecruitment;

  factory JobRecruitment.fromJson(Map<String, Object> json) =>
      _$JobRecruitmentFromJson(json);
}
