import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';

class AddStory implements FutureUseCase<Null, AddStoryParams> {
  final ChatRepository chatRepository;
  const AddStory(this.chatRepository);

  @override
  Future<Either<Failure, Null>> call(AddStoryParams params) async {
    return await chatRepository.addStory(image: params.image);
  }
}

class AddStoryParams {
  final String image;
  const AddStoryParams({
    required this.image,
  });
}
