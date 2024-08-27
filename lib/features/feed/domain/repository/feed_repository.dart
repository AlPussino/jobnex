import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/features/feed/data/model/job_recruitment.dart';

abstract interface class FeedRepository {
  Future<Either<Failure, void>> addRecruitment({
    required JobRecruitment jobRecruitment,
  });

  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getAllJobRecruitments();

  Future<Either<Failure, Null>> applyJob({
    required String jobRecruitmentId,
    required List<dynamic> candidateList,
  });
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getCandidates({required String jobRecruitementId});
}
