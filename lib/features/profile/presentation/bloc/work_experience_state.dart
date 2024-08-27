part of 'work_experience_bloc.dart';

@immutable
sealed class WorkExperienceState {
  const WorkExperienceState();
}

final class WorkExperienceInitial extends WorkExperienceState {}

final class WorkExperienceLoading extends WorkExperienceState {}

final class WorkExperienceFailure extends WorkExperienceState {
  final String message;
  const WorkExperienceFailure(this.message);
}

final class WorkExperienceGetWorkExperienceSuccess extends WorkExperienceState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> workExperiences;
  const WorkExperienceGetWorkExperienceSuccess(this.workExperiences);
}

final class WorkExperienceGetWorkExperienceByIdSuccess
    extends WorkExperienceState {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> workExperience;
  const WorkExperienceGetWorkExperienceByIdSuccess(this.workExperience);
}

final class WorkExperienceAddWorkExperienceSuccess
    extends WorkExperienceState {}

final class WorkExperienceChangeCompanyNameSuccess
    extends WorkExperienceState {}

final class WorkExperienceChangeJobPositionSuccess
    extends WorkExperienceState {}

final class WorkExperienceChangeJobLocationSuccess
    extends WorkExperienceState {}

final class WorkExperienceChangeJobTypeSuccess extends WorkExperienceState {}

final class WorkExperienceChangeWorkExperiencesDatesSuccess
    extends WorkExperienceState {}
