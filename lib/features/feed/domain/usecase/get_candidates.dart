import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/feed/domain/repository/feed_repository.dart';

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
