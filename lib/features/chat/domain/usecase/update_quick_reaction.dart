import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/chat/domain/repository/chat_repository.dart';

class UpdateQuickReaction
    implements FutureUseCase<Null, UpdateQuickReactionParams> {
  final ChatRepository chatRepository;
  const UpdateQuickReaction(this.chatRepository);

  @override
  Future<Either<Failure, Null>> call(UpdateQuickReactionParams params) async {
    return await chatRepository.updateQuickReaction(
        receiver_id: params.receiver_id, quickReact: params.quickReact);
  }
}

class UpdateQuickReactionParams {
  final String receiver_id;
  final String quickReact;
  const UpdateQuickReactionParams({
    required this.receiver_id,
    required this.quickReact,
  });
}
