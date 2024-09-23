import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';

class BlockUser implements FutureUseCase<bool, BlockUserParams> {
  final ChatRepository chatRepository;
  const BlockUser(this.chatRepository);

  @override
  Future<Either<Failure, bool>> call(BlockUserParams params) async {
    return await chatRepository.blockUser(
        receiver_id: params.receiver_id, is_block: params.is_block);
  }
}

class BlockUserParams {
  final String receiver_id;
  final bool is_block;
  const BlockUserParams({
    required this.receiver_id,
    required this.is_block,
  });
}
