import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/common/enum/message_type_enum.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/chat/domain/repository/chat_repository.dart';

class CreateChat implements FutureUseCase<Null, CreateChatParams> {
  final ChatRepository chatRepository;
  const CreateChat(this.chatRepository);

  @override
  Future<Either<Failure, Null>> call(CreateChatParams params) async {
    return await chatRepository.createChat(
      receiver_id: params.receiver_id,
      message: params.message,
      messageType: params.messageType,
    );
  }
}

class CreateChatParams {
  final String receiver_id;
  final String message;
  final MessageTypeEnum messageType;
  const CreateChatParams({
    required this.receiver_id,
    required this.message,
    required this.messageType,
  });
}
