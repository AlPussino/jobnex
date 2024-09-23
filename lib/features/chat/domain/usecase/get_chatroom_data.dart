import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';

class GetChatroomData
    implements
        FutureUseCase<Stream<DocumentSnapshot<Map<String, dynamic>>>,
            GetChatRoomDataParams> {
  final ChatRepository chatRepository;
  const GetChatroomData(this.chatRepository);

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>> call(
      GetChatRoomDataParams params) async {
    return await chatRepository.getChatRoomData(chatRoomId: params.chatRoomId);
  }
}

class GetChatRoomDataParams {
  final String chatRoomId;
  const GetChatRoomDataParams({
    required this.chatRoomId,
  });
}
