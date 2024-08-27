part of 'feed_bloc.dart';

@immutable
sealed class FeedState {
  const FeedState();
}

final class FeedInitial extends FeedState {}

final class FeedActionState extends FeedState {}

final class FeedLoading extends FeedActionState {}

final class FeedFailure extends FeedState {
  final String message;
  const FeedFailure(this.message);
}

final class FeedAddJobRecruitmentSuccessState extends FeedActionState {}

final class FeedGetAllJobRecruitmentsSuccessState extends FeedState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> jobRecruitments;
  const FeedGetAllJobRecruitmentsSuccessState(this.jobRecruitments);
}

final class FeedApplyJobSuccessState extends FeedState {}

final class FeedGetCandidatesSuccessState extends FeedState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> candidates;
  const FeedGetCandidatesSuccessState(this.candidates);
}
