import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/features/post/data/model/post.dart';
import '../../data/model/react.dart';

abstract interface class PostRepository {
  Future<Either<Failure, Null>> addPost({required Post post});
  Future<Either<Failure, Stream<List<Post>>>> getAllPosts();
  Future<Either<Failure, Stream<Post>>> getPostById({required String postId});
  Future<Either<Failure, Null>> reactPost({
    required String postId,
    required List<React> reactList,
  });
  Future<Either<Failure, Null>> commentPost({
    required String postId,
    required String commentText,
  });

  Future<Either<Failure, Null>> replyComment({
    required String post_id,
    required String comment_id,
    required String replyText,
  });

  Future<Either<Failure, Null>> deletPost({required String post_id});
}
