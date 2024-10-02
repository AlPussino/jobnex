import 'dart:io';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/common/constant/constant.dart';
import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/error/failure.dart';
import 'package:JobNex/features/chat/data/model/story.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:JobNex/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:JobNex/features/chat/domain/repository/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource chatRemoteDataSource;
  final InternetConnectionChecker connectionChecker;

  ChatRepositoryImpl(
      {required this.chatRemoteDataSource, required this.connectionChecker});

  @override
  Future<Either<Failure, Null>> createChat({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
  }) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await chatRemoteDataSource.createChat(
        receiver_id: receiver_id,
        message: message,
        messageType: messageType,
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getChatList() async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(chatRemoteDataSource.getChatList());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getChatStream({required String receiver_id}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(
          chatRemoteDataSource.getChatStream(receiver_id: receiver_id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> sendTextMessage({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
    required ChatReply? chatReply,
  }) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await chatRemoteDataSource.sendTextMessage(
        receiver_id: receiver_id,
        message: message,
        messageType: messageType,
        chatReply: chatReply,
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> sendFileMessage(
      {required String receiver_id,
      required List<File> fileList,
      required MessageTypeEnum messageType}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await chatRemoteDataSource.sendFileMessage(
        receiver_id: receiver_id,
        fileList: fileList,
        messageType: messageType,
      ));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> updateTheme(
      {required String receiver_id, required int theme}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await chatRemoteDataSource.updateTheme(
          receiver_id: receiver_id, theme: theme));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>>
      getChatRoomData({required String chatRoomId}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(
          chatRemoteDataSource.getChatRoomData(chatRoomId: chatRoomId));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> updateQuickReaction(
      {required String receiver_id, required String quickReact}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await chatRemoteDataSource.updateQuickReaction(
          receiver_id: receiver_id, quickReact: quickReact));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getFilesInChat({required String chatroom_id}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(
          chatRemoteDataSource.getFilesinChat(chatroom_id: chatroom_id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getImagesInChat({required String chatroom_id}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(
          chatRemoteDataSource.getImagesinChat(chatroom_id: chatroom_id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getVideosInChat({required String chatroom_id}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(
          chatRemoteDataSource.getVideosinChat(chatroom_id: chatroom_id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getVoicesInChat({required String chatroom_id}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(
          chatRemoteDataSource.getVoicesinChat(chatroom_id: chatroom_id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> deleteConversation(
      {required String chatroom_id}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await chatRemoteDataSource.deleteConversation(
          chatroom_id: chatroom_id));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> blockUser(
      {required String receiver_id, required bool is_block}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await chatRemoteDataSource.blockUser(
          receiver_id: receiver_id, is_block: is_block));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Null>> addStory({required String image}) async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(await chatRemoteDataSource.addStory(image: image));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, Stream<List<Story>>>> getAllStories() async {
    try {
      if (!await connectionChecker.hasConnection) {
        return left(const Failure(Constant.networkErrorMessage));
      }
      return right(chatRemoteDataSource.getAllStories());
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
