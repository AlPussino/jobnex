import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/feed/domain/repository/feed_repository.dart';

class GetCandidates
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetCandidatesParams> {
  final FeedRepository feedRepository;
  const GetCandidates(this.feedRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetCandidatesParams params) async {
    return await feedRepository.getCandidates(
        jobRecruitementId: params.jobRecruitmentId);
  }
}

class GetCandidatesParams {
  final String jobRecruitmentId;
  const GetCandidatesParams({
    required this.jobRecruitmentId,
  });
}
