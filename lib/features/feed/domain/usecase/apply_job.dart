import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/feed/domain/repository/feed_repository.dart';

class Applyjob implements FutureUseCase<void, ApplyjobParams> {
  final FeedRepository feedRepository;
  const Applyjob(this.feedRepository);

  @override
  Future<Either<Failure, void>> call(ApplyjobParams params) async {
    return await feedRepository.applyJob(
        jobRecruitmentId: params.jobRecruitmentId,
        candidateList: params.candidateList);
  }
}

class ApplyjobParams {
  final String jobRecruitmentId;
  final List<dynamic> candidateList;
  const ApplyjobParams({
    required this.jobRecruitmentId,
    required this.candidateList,
  });
}
