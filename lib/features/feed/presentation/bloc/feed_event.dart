part of 'feed_bloc.dart';

@immutable
sealed class FeedEvent {}

final class FeedAddJobRecruitment extends FeedEvent {
  final JobRecruitment jobRecruitment;
  FeedAddJobRecruitment(this.jobRecruitment);
}

final class FeedGetAllJobRecruitments extends FeedEvent {}

final class FeedApplyJob extends FeedEvent {
  final String jobRecruitmentId;
  final List<dynamic> candidateList;
  FeedApplyJob(this.jobRecruitmentId, this.candidateList);
}

final class FeedGetCandidates extends FeedEvent {
  final String jobRecruitmentId;
  FeedGetCandidates(this.jobRecruitmentId);
}
