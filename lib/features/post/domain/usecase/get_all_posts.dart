import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/post/domain/repository/post_repository.dart';

import '../../data/model/post.dart';

class GetAllPosts implements FutureUseCase<Stream<List<Post>>, NoParams> {
  final PostRepository postRepository;
  const GetAllPosts(this.postRepository);

  @override
  Future<Either<Failure, Stream<List<Post>>>> call(NoParams params) async {
    return await postRepository.getAllPosts();
  }
}
