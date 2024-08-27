import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:freezed_example/core/error/exception.dart';
import 'package:freezed_example/core/util/upload_image_to_fire_storage.dart';
import 'package:freezed_example/features/post/data/model/post.dart';
import 'package:uuid/uuid.dart';

abstract interface class PostRemoteDataSource {
  Future addPost({required Post post});
  Stream<List<Post>> getAllPosts();
  Stream<Post> getPostById({required String postId});
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
          Post newpost = post.copyWith(
              text: post.text, image: value, created_at: post.created_at);
          await fireStore.collection("posts").add(newpost.toJson());
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
}
