import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/feed/data/model/job_recruitment.dart';
import 'package:freezed_example/features/feed/domain/usecase/add_job_recruitment.dart';
import 'package:freezed_example/features/feed/domain/usecase/apply_job.dart';
import 'package:freezed_example/features/feed/domain/usecase/get_all_job_recruitments.dart';
import '../../domain/usecase/get_candidates.dart';
part 'feed_event.dart';
part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final AddJobRecruitment _addJobRecruitment;
  final GetAllJobRecruitments _getAllJobRecruitments;
  final Applyjob _applyJob;
  final GetCandidates _getCandidates;
  FeedBloc({
    required AddJobRecruitment addJobRecruitment,
    required GetAllJobRecruitments getAllJobRecruitments,
    required Applyjob applyJob,
    required GetCandidates getCandidates,
  })  : _addJobRecruitment = addJobRecruitment,
        _getAllJobRecruitments = getAllJobRecruitments,
        _applyJob = applyJob,
        _getCandidates = getCandidates,
        super(FeedInitial()) {
    on<FeedEvent>((_, emit) => emit(FeedLoading()));
    on<FeedAddJobRecruitment>(onFeedAddJobRecruitment);
    on<FeedGetAllJobRecruitments>(onFeedGetAllJobRecruitments);
    on<FeedApplyJob>(onFeedApplyJob);
    on<FeedGetCandidates>(onFeedGetCandidates);
  }

  void onFeedAddJobRecruitment(
      FeedAddJobRecruitment event, Emitter<FeedState> emit) async {
    final response = await _addJobRecruitment
        .call(AddJobRecruitmentParams(jobRecruitment: event.jobRecruitment));

    response.fold((failure) => emit(FeedFailure(failure.message)),
        (_) => emit(FeedAddJobRecruitmentSuccessState()));
  }

  void onFeedGetAllJobRecruitments(
      FeedGetAllJobRecruitments event, Emitter<FeedState> emit) async {
    final response = await _getAllJobRecruitments.call(NoParams());

    response.fold(
        (failure) => emit(FeedFailure(failure.message)),
        (jobRecruitments) =>
            emit(FeedGetAllJobRecruitmentsSuccessState(jobRecruitments)));
  }

  void onFeedApplyJob(FeedApplyJob event, Emitter<FeedState> emit) async {
    final response = await _applyJob.call(ApplyjobParams(
        jobRecruitmentId: event.jobRecruitmentId,
        candidateList: event.candidateList));

    response.fold((failure) => emit(FeedFailure(failure.message)),
        (_) => emit(FeedApplyJobSuccessState()));
  }

  void onFeedGetCandidates(
      FeedGetCandidates event, Emitter<FeedState> emit) async {
    final response = await _getCandidates
        .call(GetCandidatesParams(jobRecruitmentId: event.jobRecruitmentId));

    response.fold((failure) => emit(FeedFailure(failure.message)),
        (candidates) => emit(FeedGetCandidatesSuccessState(candidates)));
  }
}
