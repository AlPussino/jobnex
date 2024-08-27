part of 'applied_jobs_bloc.dart';

@immutable
sealed class AppliedJobsEvent {}

final class AppliedJobsGetUserAppliedJobs extends AppliedJobsEvent {
  final String user_id;
  AppliedJobsGetUserAppliedJobs(this.user_id);
}
