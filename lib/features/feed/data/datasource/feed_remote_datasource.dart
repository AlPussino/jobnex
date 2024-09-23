import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:JobNex/core/error/exception.dart';
import 'package:JobNex/features/feed/data/model/job_recruitment.dart';

abstract interface class FeedRemoteDataSource {
  Future<void> addJobRecruitment({required JobRecruitment jobRecruitment});
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllJobRecruitments();
  Future applyJob({
    required String jobRecruitmentId,
    required List<dynamic> candidateList,
  });
  Stream<QuerySnapshot<Map<String, dynamic>>> getCandidates({
    required String jobRecruitmentId,
  });
}

class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final FirebaseAuth fireAuth;
  final FirebaseFirestore fireStore;
  final FirebaseMessaging fireMessage;
  final FirebaseStorage firebaseStorage;

  FeedRemoteDataSourceImpl({
    required this.fireAuth,
    required this.fireStore,
    required this.fireMessage,
    required this.firebaseStorage,
  });

  @override
  Future<void> addJobRecruitment(
      {required JobRecruitment jobRecruitment}) async {
    try {
      await fireStore.collection("recruitments").add(jobRecruitment.toJson());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllJobRecruitments() {
    try {
      return fireStore
          .collection("recruitments")
          .orderBy("created_at", descending: true)
          .snapshots(includeMetadataChanges: false);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future applyJob(
      {required String jobRecruitmentId,
      required List<dynamic> candidateList}) async {
    try {
      await fireStore.collection("recruitments").doc(jobRecruitmentId).update({
        "candidates": candidateList,
      }).then(
        (value) async {
          await fireStore
              .collection("users")
              .doc(fireAuth.currentUser!.uid)
              .collection("applied_job_collections")
              .add({
            "job_recruitments":
                fireStore.collection("recruitments").doc(jobRecruitmentId),
          });
        },
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getCandidates(
      {required String jobRecruitmentId}) {
    try {
      return fireStore
          .collection("recruitments")
          .doc(jobRecruitmentId)
          .collection("candidateCollection")
          .snapshots();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
