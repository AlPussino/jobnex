import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/common/constant/constant.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/features/applied_jobs/data/datasource/applied_jobs_remote_datasource.dart';
import 'package:JobNex/features/applied_jobs/domain/repository/applied_jobs_repository.dart';

class AppliedJobsRepositoryImpl implements AppliedJobsRepository {
  final AppliedJobsRemoteDataSource appliedJobsRemoteDataSource;
  final InternetConnectionChecker connectionChecker;

  AppliedJobsRepositoryImpl({
    required this.appliedJobsRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getUserAppliedJobs({required String user_id}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(
          appliedJobsRemoteDataSource.getUserAppliedJobs(user_id: user_id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
