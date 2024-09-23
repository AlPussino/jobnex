import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:JobNex/features/applied_jobs/domain/usercase/get_user_applied_jobs.dart';
part 'applied_jobs_event.dart';
part 'applied_jobs_state.dart';

class AppliedJobsBloc extends Bloc<AppliedJobsEvent, AppliedJobsState> {
  final GetUserAppliedJobs _getUserAppliedJobs;

  AppliedJobsBloc({
    required GetUserAppliedJobs getUserAppliedJobs,
  })  : _getUserAppliedJobs = getUserAppliedJobs,
        super(AppliedJobsInitial()) {
    on<AppliedJobsEvent>((_, emit) => emit(AppliedJobsLoading()));
    on<AppliedJobsGetUserAppliedJobs>(onAppliedJobsGetUserAppliedJobs);
  }

  void onAppliedJobsGetUserAppliedJobs(AppliedJobsGetUserAppliedJobs event,
      Emitter<AppliedJobsState> emit) async {
    final response = await _getUserAppliedJobs
        .call(GetUserAppliedJobsParams(user_id: event.user_id));

    response.fold(
        (failure) => emit(AppliedJobsFailure(failure.message)),
        (appliedJobs) =>
            emit(AppliedJobsGetUserAppliedJobsSuccess(appliedJobs)));
  }
}
