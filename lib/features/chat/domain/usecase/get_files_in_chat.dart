import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';

class GetFilesInChat
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetFilesInChatParams> {
  final ChatRepository chatRepository;
  const GetFilesInChat(this.chatRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetFilesInChatParams params) async {
    return await chatRepository.getFilesInChat(chatroom_id: params.chatroom_id);
  }
}

class GetFilesInChatParams {
  final String chatroom_id;
  const GetFilesInChatParams({
    required this.chatroom_id,
  });
}
