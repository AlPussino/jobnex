import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/post/domain/repository/post_repository.dart';

import '../../data/model/post.dart';

class GetAllPosts implements FutureUseCase<Stream<List<Post>>, NoParams> {
  final PostRepository postRepository;
  const GetAllPosts(this.postRepository);

  @override
  Future<Either<Failure, Stream<List<Post>>>> call(NoParams params) async {
    return await postRepository.getAllPosts();
  }
}
