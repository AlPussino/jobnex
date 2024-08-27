part of 'applied_jobs_bloc.dart';

@immutable
sealed class AppliedJobsState {
  const AppliedJobsState();
}

final class AppliedJobsInitial extends AppliedJobsState {}

final class AppliedJobsLoading extends AppliedJobsState {}

final class AppliedJobsFailure extends AppliedJobsState {
  final String message;
  const AppliedJobsFailure(this.message);
}

final class AppliedJobsGetUserAppliedJobsSuccess extends AppliedJobsState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> appliedJobs;
  const AppliedJobsGetUserAppliedJobsSuccess(this.appliedJobs);
}
