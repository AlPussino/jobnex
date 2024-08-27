import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/common/constant/constant.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/features/post/data/datasource/post_remote_datasource.dart';
import 'package:freezed_example/features/post/data/model/post.dart';
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
}
