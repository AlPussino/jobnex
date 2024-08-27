import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/features/post/data/model/post.dart';

abstract interface class PostRepository {
  Future<Either<Failure, Null>> addPost({
    required Post post,
  });
  Future<Either<Failure, Stream<List<Post>>>> getAllPosts();
  Future<Either<Failure, Stream<Post>>> getPostById({required String postId});
}
