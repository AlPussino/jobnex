import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/post/domain/repository/post_repository.dart';

class DeletePost implements FutureUseCase<Null, DeletePostParams> {
  final PostRepository postRepository;
  const DeletePost(this.postRepository);

  @override
  Future<Either<Failure, Null>> call(DeletePostParams params) async {
    return await postRepository.deletPost(post_id: params.post_id);
  }
}

class DeletePostParams {
  final String post_id;

  const DeletePostParams({
    required this.post_id,
  });
}
