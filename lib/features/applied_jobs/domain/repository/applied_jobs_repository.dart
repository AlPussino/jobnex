import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';

abstract interface class AppliedJobsRepository {
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getUserAppliedJobs({required String user_id});
}
