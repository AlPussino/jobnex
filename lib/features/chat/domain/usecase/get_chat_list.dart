import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';

class GetChatList
    implements
        FutureUseCase<Stream<QuerySnapshot<Map<String, dynamic>>>, NoParams> {
  final ChatRepository chatRepository;
  const GetChatList(this.chatRepository);

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>> call(
      NoParams params) async {
    return await chatRepository.getChatList();
  }
}
