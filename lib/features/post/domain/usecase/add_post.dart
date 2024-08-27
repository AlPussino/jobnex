import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/post/data/model/post.dart';
import 'package:freezed_example/features/post/domain/repository/post_repository.dart';

class AddPost implements FutureUseCase<Null, AddPostParams> {
  final PostRepository postRepository;
  const AddPost(this.postRepository);

  @override
  Future<Either<Failure, Null>> call(AddPostParams params) async {
    return await postRepository.addPost(post: params.post);
  }
}

class AddPostParams {
  final Post post;
  const AddPostParams({
    required this.post,
  });
}
