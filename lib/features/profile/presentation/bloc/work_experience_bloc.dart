import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:JobNex/features/profile/data/model/work_experience.dart';
import 'package:JobNex/features/profile/domain/usecase/add_work_experience.dart';
import 'package:JobNex/features/profile/domain/usecase/change_company_name.dart';
import 'package:JobNex/features/profile/domain/usecase/change_job_location.dart';
import 'package:JobNex/features/profile/domain/usecase/change_job_position.dart';
import 'package:JobNex/features/profile/domain/usecase/change_job_type.dart';
import 'package:JobNex/features/profile/domain/usecase/change_work_experiences_dates.dart';
import 'package:JobNex/features/profile/domain/usecase/get_work_experience_by_id.dart';
import 'package:JobNex/features/profile/domain/usecase/get_work_experiences.dart';

part 'work_experience_event.dart';
part 'work_experience_state.dart';

class WorkExperienceBloc
    extends Bloc<WorkExperienceEvent, WorkExperienceState> {
  final GetWorkExperiences _getWorkExperiences;
  final AddWorkExperience _addWorkExperience;
  final ChangeCompanyName _changeCompanyName;
  final ChangeJobPosition _changeJobPosition;
  final ChangeJobLocation _changeJobLocation;
  final ChangeJobType _changeJobType;
  final ChangeWorkExperiencesDates _changeWorkExperiencesDates;
  final GetWorkExperienceById _getWorkExperienceById;
  WorkExperienceBloc({
    required GetWorkExperiences getWorkExperiences,
    required AddWorkExperience addWorkExperience,
    required ChangeCompanyName changeCompanyName,
    required ChangeJobPosition changeJobPosition,
    required ChangeJobLocation changeJobLocation,
    required ChangeJobType changeJobType,
    required ChangeWorkExperiencesDates changeWorkExperiencesDates,
    required GetWorkExperienceById getWorkExperienceById,
  })  : _getWorkExperiences = getWorkExperiences,
        _addWorkExperience = addWorkExperience,
        _changeCompanyName = changeCompanyName,
        _changeJobPosition = changeJobPosition,
        _changeJobLocation = changeJobLocation,
        _changeJobType = changeJobType,
        _changeWorkExperiencesDates = changeWorkExperiencesDates,
        _getWorkExperienceById = getWorkExperienceById,
        super(WorkExperienceInitial()) {
    // on<WorkExperienceEvent>((_, emit) => emit(WorkExperienceLoading()));
    on<WorkExperienceGetWorkExperience>(onWorkExperienceGetWorkExperiences);
    on<WorkExperienceAddWorkExperience>(onWorkExperienceAddWorkExperience);
    on<WorkExperienceChangeCompanyName>(onWorkExperienceChangeCompanyName);
    on<WorkExperienceChangeJobPosition>(onWorkExperienceChangeJobPosition);
    on<WorkExperienceChangeJobLocation>(onWorkExperienceChangeJobLocation);
    on<WorkExperienceChangeJobType>(onWorkExperienceChangeJobType);
    on<WorkExperienceChangeWorkExperiencesDates>(
        onWorkExperienceChangeWorkExperiencesDates);
    on<WorkExperienceGetWorkExperienceById>(
        onWorkExperienceGetWorkExperiencesById);
  }

  void onWorkExperienceGetWorkExperiences(WorkExperienceGetWorkExperience event,
      Emitter<WorkExperienceState> emit) async {
    final response = await _getWorkExperiences
        .call(GetWorkExperiencesParams(user_id: event.user_id));

    response.fold(
        (failure) => emit(WorkExperienceFailure(failure.message)),
        (workExperiences) =>
            emit(WorkExperienceGetWorkExperienceSuccess(workExperiences)));
  }

  void onWorkExperienceGetWorkExperiencesById(
      WorkExperienceGetWorkExperienceById event,
      Emitter<WorkExperienceState> emit) async {
    final response = await _getWorkExperienceById.call(
        GetWorkExperienceByIdParams(
            user_id: event.user_id,
            workexperience_id: event.workExperience_id));

    response.fold(
        (failure) => emit(WorkExperienceFailure(failure.message)),
        (workExperience) =>
            emit(WorkExperienceGetWorkExperienceByIdSuccess(workExperience)));
  }

  void onWorkExperienceAddWorkExperience(WorkExperienceAddWorkExperience event,
      Emitter<WorkExperienceState> emit) async {
    final response = await _addWorkExperience
        .call(AddWorkExperienceParams(workExperience: event.workExperience));

    response.fold((failure) => emit(WorkExperienceFailure(failure.message)),
        (_) => emit(WorkExperienceAddWorkExperienceSuccess()));
  }

  void onWorkExperienceChangeCompanyName(WorkExperienceChangeCompanyName event,
      Emitter<WorkExperienceState> emit) async {
    final response = await _changeCompanyName.call(ChangeCompanyNameParams(
        workExperience_id: event.workExperience_id,
        company_name: event.company_name));

    response.fold((failure) => emit(WorkExperienceFailure(failure.message)),
        (_) => emit(WorkExperienceChangeCompanyNameSuccess()));
  }

  void onWorkExperienceChangeJobPosition(WorkExperienceChangeJobPosition event,
      Emitter<WorkExperienceState> emit) async {
    final response = await _changeJobPosition.call(ChangeJobPositionParams(
        workExperience_id: event.workExperience_id,
        job_position: event.job_position));

    response.fold((failure) => emit(WorkExperienceFailure(failure.message)),
        (_) => emit(WorkExperienceChangeJobPositionSuccess()));
  }

  void onWorkExperienceChangeJobLocation(WorkExperienceChangeJobLocation event,
      Emitter<WorkExperienceState> emit) async {
    final response = await _changeJobLocation.call(ChangeJobLocationParams(
        workExperience_id: event.workExperience_id,
        job_location: event.job_location));

    response.fold((failure) => emit(WorkExperienceFailure(failure.message)),
        (_) => emit(WorkExperienceChangeJobLocationSuccess()));
  }

  void onWorkExperienceChangeJobType(WorkExperienceChangeJobType event,
      Emitter<WorkExperienceState> emit) async {
    final response = await _changeJobType.call(ChangeJobTypeParams(
        workExperience_id: event.workExperience_id, job_type: event.job_type));

    response.fold((failure) => emit(WorkExperienceFailure(failure.message)),
        (_) => emit(WorkExperienceChangeJobTypeSuccess()));
  }

  void onWorkExperienceChangeWorkExperiencesDates(
      WorkExperienceChangeWorkExperiencesDates event,
      Emitter<WorkExperienceState> emit) async {
    final response = await _changeWorkExperiencesDates.call(
        ChangeWorkExperiencesDatesParams(
            workExperience_id: event.workExperience_id,
            start_date: event.start_date,
            stop_date: event.stop_date,
            still_working: event.still_working));

    response.fold((failure) => emit(WorkExperienceFailure(failure.message)),
        (_) => emit(WorkExperienceChangeWorkExperiencesDatesSuccess()));
  }
}
