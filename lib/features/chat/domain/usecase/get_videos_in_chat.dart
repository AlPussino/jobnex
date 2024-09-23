import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';

class GetVideosInChat
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>,
            GetVideosInChatParams> {
  final ChatRepository chatRepository;
  const GetVideosInChat(this.chatRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      GetVideosInChatParams params) async {
    return await chatRepository.getVideosInChat(
        chatroom_id: params.chatroom_id);
  }
}

class GetVideosInChatParams {
  final String chatroom_id;
  const GetVideosInChatParams({
    required this.chatroom_id,
  });
}
