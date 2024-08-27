import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/feed/data/model/job_recruitment.dart';
import 'package:freezed_example/features/feed/domain/repository/feed_repository.dart';

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
