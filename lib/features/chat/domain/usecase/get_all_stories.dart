import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';
import '../../data/model/story.dart';

class GetAllStories implements FutureUseCase<Stream<List<Story>>, NoParams> {
  final ChatRepository chatRepository;
  const GetAllStories(this.chatRepository);

  @override
  Future<Either<Failure, Stream<List<Story>>>> call(NoParams params) async {
    return await chatRepository.getAllStories();
  }
}
