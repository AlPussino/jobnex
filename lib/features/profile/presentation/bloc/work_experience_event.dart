part of 'work_experience_bloc.dart';

@immutable
sealed class WorkExperienceEvent {}

final class WorkExperienceGetWorkExperience extends WorkExperienceEvent {
  final String user_id;
  WorkExperienceGetWorkExperience(this.user_id);
}

final class WorkExperienceAddWorkExperience extends WorkExperienceEvent {
  final WorkExperience workExperience;
  WorkExperienceAddWorkExperience(this.workExperience);
}

final class WorkExperienceGetWorkExperienceById extends WorkExperienceEvent {
  final String user_id;
  final String workExperience_id;
  WorkExperienceGetWorkExperienceById(this.user_id, this.workExperience_id);
}

final class WorkExperienceChangeCompanyName extends WorkExperienceEvent {
  final String workExperience_id;
  final String company_name;
  WorkExperienceChangeCompanyName(this.workExperience_id, this.company_name);
}

final class WorkExperienceChangeJobPosition extends WorkExperienceEvent {
  final String workExperience_id;
  final String job_position;
  WorkExperienceChangeJobPosition(this.workExperience_id, this.job_position);
}

final class WorkExperienceChangeJobLocation extends WorkExperienceEvent {
  final String workExperience_id;
  final String job_location;
  WorkExperienceChangeJobLocation(this.workExperience_id, this.job_location);
}

final class WorkExperienceChangeJobType extends WorkExperienceEvent {
  final String workExperience_id;
  final String job_type;
  WorkExperienceChangeJobType(this.workExperience_id, this.job_type);
}

final class WorkExperienceChangeWorkExperiencesDates
    extends WorkExperienceEvent {
  final String workExperience_id;
  final String start_date;
  final String stop_date;
  final bool still_working;
  WorkExperienceChangeWorkExperiencesDates(
    this.workExperience_id,
    this.start_date,
    this.stop_date,
    this.still_working,
  );
}
