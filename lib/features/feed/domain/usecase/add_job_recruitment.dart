import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/feed/data/model/job_recruitment.dart';
import 'package:JobNex/features/feed/domain/repository/feed_repository.dart';

class AddJobRecruitment
    implements FutureUseCase<void, AddJobRecruitmentParams> {
  final FeedRepository feedRepository;
  const AddJobRecruitment(this.feedRepository);

  @override
  Future<Either<Failure, void>> call(AddJobRecruitmentParams params) async {
    return await feedRepository.addRecruitment(
        jobRecruitment: params.jobRecruitment);
  }
}

class AddJobRecruitmentParams {
  final JobRecruitment jobRecruitment;
  const AddJobRecruitmentParams({
    required this.jobRecruitment,
  });
}
