import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/error/failure.dart';

import '../../data/model/story.dart';

abstract interface class ChatRepository {
  Future<Either<Failure, Null>> createChat({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
  });

  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getChatList();

  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getChatStream({required String receiver_id});

  Future<Either<Failure, Null>> sendTextMessage({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
  });

  Future<Either<Failure, Null>> sendFileMessage({
    required String receiver_id,
    required List<File> fileList,
    required MessageTypeEnum messageType,
  });

  Future<Either<Failure, Null>> updateTheme({
    required String receiver_id,
    required int theme,
  });

  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>>
      getChatRoomData({required String chatRoomId});

  Future<Either<Failure, Null>> updateQuickReaction({
    required String receiver_id,
    required String quickReact,
  });

  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getImagesInChat({required String chatroom_id});

  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getVideosInChat({required String chatroom_id});

  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getVoicesInChat({required String chatroom_id});

  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>>>
      getFilesInChat({required String chatroom_id});

  Future<Either<Failure, Null>> deleteConversation({
    required String chatroom_id,
  });

  Future<Either<Failure, bool>> blockUser({
    required String receiver_id,
    required bool is_block,
  });

  Future<Either<Failure, Null>> addStory({required String image});

  Future<Either<Failure, Stream<List<Story>>>> getAllStories();
}
