import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/chat/domain/repository/chat_repository.dart';

class GetChatStream
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetChatStreamParams> {
  final ChatRepository chatRepository;
  const GetChatStream(this.chatRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetChatStreamParams params) async {
    return await chatRepository.getChatStream(receiver_id: params.receiver_id);
  }
}

class GetChatStreamParams {
  final String receiver_id;
  const GetChatStreamParams({
    required this.receiver_id,
  });
}
