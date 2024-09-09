import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/post/domain/repository/post_repository.dart';

class CommentPost implements FutureUseCase<Null, CommentPostParams> {
  final PostRepository postRepository;
  const CommentPost(this.postRepository);

  @override
  Future<Either<Failure, Null>> call(CommentPostParams params) async {
    return await postRepository.commentPost(
        postId: params.postId, commentText: params.commentText);
  }
}

class CommentPostParams {
  final String postId;
  final String commentText;
  const CommentPostParams({
    required this.postId,
    required this.commentText,
  });
}
