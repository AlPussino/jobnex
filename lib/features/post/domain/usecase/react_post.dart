import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/post/domain/repository/post_repository.dart';
import '../../data/model/react.dart';

class ReactPost implements FutureUseCase<Null, ReactPostParams> {
  final PostRepository postRepository;
  const ReactPost(this.postRepository);

  @override
  Future<Either<Failure, Null>> call(ReactPostParams params) async {
    return await postRepository.reactPost(
        postId: params.postId, reactList: params.reactList);
  }
}

class ReactPostParams {
  final String postId;
  final List<React> reactList;
  const ReactPostParams({
    required this.postId,
    required this.reactList,
  });
}
