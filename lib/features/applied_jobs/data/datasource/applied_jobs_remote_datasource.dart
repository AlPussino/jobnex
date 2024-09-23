import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:JobNex/core/error/exception.dart';

abstract interface class AppliedJobsRemoteDataSource {
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserAppliedJobs(
      {required String user_id});
}

class AppliedJobsRemoteDataSourceImpl implements AppliedJobsRemoteDataSource {
  final FirebaseAuth fireAuth;
  final FirebaseFirestore fireStore;
  final FirebaseMessaging fireMessage;
  final FirebaseStorage firebaseStorage;

  AppliedJobsRemoteDataSourceImpl({
    required this.fireAuth,
    required this.fireStore,
    required this.fireMessage,
    required this.firebaseStorage,
  });

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUserAppliedJobs(
      {required String user_id}) {
    try {
      return fireStore
          .collection("users")
          .doc(user_id)
          .collection("applied_job_collections")
          .snapshots(includeMetadataChanges: false);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
