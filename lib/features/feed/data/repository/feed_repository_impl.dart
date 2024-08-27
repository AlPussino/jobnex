import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/common/constant/constant.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/features/feed/data/model/job_recruitment.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:freezed_example/features/feed/data/datasource/feed_remote_datasource.dart';
import 'package:freezed_example/features/feed/domain/repository/feed_repository.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource feedRemoteDataSource;
  final InternetConnectionChecker connectionChecker;

  FeedRepositoryImpl({
    required this.feedRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, void>> addRecruitment(
      {required JobRecruitment jobRecruitment}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await feedRemoteDataSource.addJobRecruitment(
        jobRecruitment: jobRecruitment,
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getAllJobRecruitments() async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(feedRemoteDataSource.getAllJobRecruitments());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> applyJob(
      {required String jobRecruitmentId,
      required List<dynamic> candidateList}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await feedRemoteDataSource.applyJob(
          jobRecruitmentId: jobRecruitmentId, candidateList: candidateList));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getCandidates({required String jobRecruitementId}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(feedRemoteDataSource.getCandidates(
          jobRecruitmentId: jobRecruitementId));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
