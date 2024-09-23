import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';

class GetImagesInChat
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetImagesInChatParams> {
  final ChatRepository chatRepository;
  const GetImagesInChat(this.chatRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetImagesInChatParams params) async {
    return await chatRepository.getImagesInChat(
        chatroom_id: params.chatroom_id);
  }
}

class GetImagesInChatParams {
  final String chatroom_id;
  const GetImagesInChatParams({
    required this.chatroom_id,
  });
}
