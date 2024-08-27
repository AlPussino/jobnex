import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:freezed_example/core/common/enum/message_type_enum.dart';
import 'package:freezed_example/core/error/failure.dart';
import 'package:freezed_example/core/usecase/usecase.dart';
import 'package:freezed_example/features/chat/domain/repository/chat_repository.dart';

class SendFileMessage implements FutureUseCase<Null, SendFileMessageParams> {
  final ChatRepository chatRepository;
  const SendFileMessage(this.chatRepository);

  @override
  Future<Either<Failure, Null>> call(SendFileMessageParams params) async {
    return await chatRepository.sendFileMessage(
      receiver_id: params.receiver_id,
      fileList: params.fileList,
      messageType: params.messageType,
    );
  }
}

class SendFileMessageParams {
  final String receiver_id;
  final List<File> fileList;
  final MessageTypeEnum messageType;
  const SendFileMessageParams({
    required this.receiver_id,
    required this.fileList,
    required this.messageType,
  });
}
