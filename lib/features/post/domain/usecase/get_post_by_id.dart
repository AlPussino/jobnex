import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/post/domain/repository/post_repository.dart';

import '../../data/model/post.dart';

class GetPostById implements FutureUseCase<Stream<Post>, GetPostByIdParams> {
  final PostRepository postRepository;
  const GetPostById(this.postRepository);

  @override
  Future<Either<Failure, Stream<Post>>> call(GetPostByIdParams params) async {
    return await postRepository.getPostById(postId: params.postId);
  }
}

class GetPostByIdParams {
  final String postId;
  const GetPostByIdParams({
    required this.postId,
  });
}
