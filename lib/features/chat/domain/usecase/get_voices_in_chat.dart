import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/chat/domain/repository/chat_repository.dart';

class GetVoicesInChat
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetVoicesInChatParams> {
  final ChatRepository chatRepository;
  const GetVoicesInChat(this.chatRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetVoicesInChatParams params) async {
    return await chatRepository.getVoicesInChat(
        chatroom_id: params.chatroom_id);
  }
}

class GetVoicesInChatParams {
  final String chatroom_id;
  const GetVoicesInChatParams({
    required this.chatroom_id,
  });
}
