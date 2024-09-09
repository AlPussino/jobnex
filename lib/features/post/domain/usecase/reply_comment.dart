import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/post/domain/repository/post_repository.dart';

class ReplyComment implements FutureUseCase<Null, ReplyCommentParams> {
  final PostRepository postRepository;
  const ReplyComment(this.postRepository);

  @override
  Future<Either<Failure, Null>> call(ReplyCommentParams params) async {
    return await postRepository.replyComment(
        post_id: params.post_id,
        comment_id: params.comment_id,
        replyText: params.replyText);
  }
}

class ReplyCommentParams {
  final String post_id;
  final String comment_id;
  final String replyText;
  const ReplyCommentParams({
    required this.post_id,
    required this.comment_id,
    required this.replyText,
  });
}
