import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/applied_jobs/domain/repository/applied_jobs_repository.dart';

class GetUserAppliedJobs
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetUserAppliedJobsParams> {
  final AppliedJobsRepository appliedJobsRepository;

  const GetUserAppliedJobs(this.appliedJobsRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetUserAppliedJobsParams params) async {
    return await appliedJobsRepository.getUserAppliedJobs(
        user_id: params.user_id);
  }
}

class GetUserAppliedJobsParams {
  final String user_id;
  const GetUserAppliedJobsParams({
    required this.user_id,
  });
}
