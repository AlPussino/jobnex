import 'package:cloud_firestore/cloud_firestore.dart';

class GetPostOwnerInfo {
  Stream<DocumentSnapshot<Map<String, dynamic>>> getPostOwnerInfo({
    required String post_owner_id,
  }) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(post_owner_id)
        .snapshots();
  }
}
