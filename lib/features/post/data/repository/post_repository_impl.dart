import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/common/constant/constant.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/features/post/data/datasource/post_remote_datasource.dart';
import 'package:freezed_example/features/post/data/model/post.dart';
import 'package:freezed_example/features/post/data/model/react.dart';
import 'package:freezed_example/features/post/domain/repository/post_repository.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class PostRepositoryImpl implements PostRepository {
  final PostRemoteDataSource postRemoteDataSource;
  final InternetConnectionChecker connectionChecker;

  PostRepositoryImpl({
    required this.postRemoteDataSource,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failure, Null>> addPost({required Post post}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await postRemoteDataSource.addPost(
        post: post,
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Post>>>> getAllPosts() async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(postRemoteDataSource.getAllPosts());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<Post>>> getPostById(
      {required String postId}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(postRemoteDataSource.getPostById(postId: postId));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> reactPost(
      {required String postId, required List<React> reactList}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await postRemoteDataSource.reactPost(
          postId: postId, reactList: reactList));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> commentPost(
      {required String postId, required String commentText}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await postRemoteDataSource.commentPost(
          postId: postId, commentText: commentText));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> replyComment({
    required String post_id,
    required String comment_id,
    required String replyText,
  }) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await postRemoteDataSource.replyComment(
          postId: post_id, commentId: comment_id, replyText: replyText));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
