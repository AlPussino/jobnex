import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_example/core/error/exception.dart';
import 'package:freezed_example/core/util/upload_image_to_fire_storage.dart';
import 'package:freezed_example/features/post/data/model/comment.dart';
import 'package:freezed_example/features/post/data/model/post.dart';
import 'package:freezed_example/features/post/data/model/react.dart';
import 'package:uuid/uuid.dart';

import '../model/reply.dart';

abstract interface class PostRemoteDataSource {
  Future addPost({required Post post});
  Stream<List<Post>> getAllPosts();
  Stream<Post> getPostById({required String postId});
  Future reactPost({required String postId, required List<React> reactList});
  Future commentPost({
    required String postId,
    required String commentText,
  });
  Future replyComment({
    required String postId,
    required String commentId,
    required String replyText,
  });
}

class PostRemoteDataSourceImpl implements PostRemoteDataSource {
  final FirebaseAuth fireAuth;
  final FirebaseFirestore fireStore;
  final FirebaseMessaging fireMessage;
  final FirebaseStorage firebaseStorage;

  PostRemoteDataSourceImpl({
    required this.fireAuth,
    required this.fireStore,
    required this.fireMessage,
    required this.firebaseStorage,
  });

  @override
  Future addPost({required Post post}) async {
    try {
      final id = const Uuid().v1();
      await UploadImageToFireStorage(
        imageFile: File(post.image),
        ref: "postImages/${fireAuth.currentUser!.uid}/$id",
        firebaseStorage: firebaseStorage,
      ).then(
        (value) async {
          // Post
          DocumentReference docRef = fireStore.collection('posts').doc();
          Post newpost = post.copyWith(
            id: docRef.id,
            post_title: post.post_title,
            post_body: post.post_body,
            post_owner_id: fireAuth.currentUser!.uid,
            image: value,
            created_at: post.created_at,
            reacts: [],
            comments: [],
          );

          await docRef.set(newpost.toJson());
        },
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<List<Post>> getAllPosts() {
    try {
      return fireStore
          .collection("posts")
          .orderBy("created_at", descending: true)
          .snapshots()
          .map((event) =>
              event.docs.map((e) => Post.fromJson(e.data())).toList());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<Post> getPostById({required String postId}) {
    try {
      return fireStore
          .collection("posts")
          .doc(postId)
          .snapshots()
          .map((event) => Post.fromJson(event.data()!));
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future reactPost({
    required String postId,
    required List<React> reactList,
  }) async {
    try {
      await fireStore.collection("posts").doc(postId).update({
        "reacts": reactList.map((e) => e.toJson()).toList(),
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future commentPost({
    required String postId,
    required String commentText,
  }) async {
    try {
      DocumentReference postDocRef =
          FirebaseFirestore.instance.collection('posts').doc(postId);

      Comment newComment = Comment(
        comment_id: postDocRef.collection('comments').doc().id,
        comment: commentText,
        comment_owner_id: FirebaseAuth.instance.currentUser!.uid,
        created_at: DateTime.now(),
        replies: [],
      );

      await postDocRef.update({
        'comments': FieldValue.arrayUnion([newComment.toJson()]),
      });
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future replyComment({
    required String postId,
    required String commentId,
    required String replyText,
  }) async {
    try {
      DocumentReference postDocRef =
          FirebaseFirestore.instance.collection('posts').doc(postId);

      // Fetch the post document to get the comments array
      DocumentSnapshot postSnapshot = await postDocRef.get();
      if (postSnapshot.exists) {
        List<dynamic> comments = postSnapshot['comments'] ?? [];

        // Find the comment that matches the commentId
        int commentIndex = comments
            .indexWhere((comment) => comment['comment_id'] == commentId);

        if (commentIndex != -1) {
          // Create a new reply
          Reply newReply = Reply(
            reply_id: postDocRef
                .collection('comments')
                .doc()
                .id, // Generating unique ID for the reply
            reply: replyText,
            reply_owner_id: FirebaseAuth.instance.currentUser!.uid,
            created_at: DateTime.now(),
          );

          // Append the reply to the comment's replies array
          List<dynamic> replies = comments[commentIndex]['replies'] ?? [];
          replies.add(newReply.toJson());

          // Update the specific comment with the new replies array
          comments[commentIndex]['replies'] = replies;

          // Write the updated comments array back to Firestore
          await postDocRef.update({'comments': comments});
        }
      }
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
