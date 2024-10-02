import 'dart:io';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/error/exception.dart';
import 'package:JobNex/core/util/upload_file_list_to_fire_storage.dart';
import 'package:JobNex/core/util/upload_image_to_fire_storage.dart';
import 'package:JobNex/features/chat/data/model/story.dart';
import 'package:JobNex/features/chat/data/model/story_body.dart';
import 'package:uuid/uuid.dart';

abstract interface class ChatRemoteDataSource {
  Future createChat({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
  });

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList();

  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream({
    required String receiver_id,
  });

  Future sendTextMessage({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
    required ChatReply? chatReply,
  });

  Future sendFileMessage({
    required String receiver_id,
    required List<File> fileList,
    required MessageTypeEnum messageType,
  });

  Stream<DocumentSnapshot<Map<String, dynamic>>> getChatRoomData(
      {required String chatRoomId});

  Future updateTheme({required String receiver_id, required int theme});

  Future updateQuickReaction(
      {required String receiver_id, required String quickReact});

  Stream<QuerySnapshot<Map<String, dynamic>>> getImagesinChat(
      {required String chatroom_id});
  Stream<QuerySnapshot<Map<String, dynamic>>> getVideosinChat(
      {required String chatroom_id});
  Stream<QuerySnapshot<Map<String, dynamic>>> getVoicesinChat(
      {required String chatroom_id});
  Stream<QuerySnapshot<Map<String, dynamic>>> getFilesinChat(
      {required String chatroom_id});

  Future deleteConversation({required String chatroom_id});

  Future<bool> blockUser({required String receiver_id, required bool is_block});

  Future addStory({required String image});

  Stream<List<Story>> getAllStories();
}

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final FirebaseAuth fireAuth;
  final FirebaseFirestore fireStore;
  final FirebaseMessaging fireMessage;
  final FirebaseStorage firebaseStorage;

  ChatRemoteDataSourceImpl({
    required this.fireAuth,
    required this.fireStore,
    required this.fireMessage,
    required this.firebaseStorage,
  });

  Future<void> saveDataToChatCollection({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
  }) async {
    await fireStore
        .collection("users")
        .doc(fireAuth.currentUser!.uid)
        .collection("chats")
        .doc(receiver_id)
        .set({
      "chat_contact": fireStore.collection("users").doc(receiver_id),
      "message_type": messageType.type,
      "last_message": message,
      "time_sent": DateTime.now(),
      "quick_react": "👍",
      "theme": 4289961435,
      "block": false,
      "block_by": "",
    });

    await fireStore
        .collection("users")
        .doc(receiver_id)
        .collection("chats")
        .doc(fireAuth.currentUser!.uid)
        .set({
      "chat_contact":
          fireStore.collection("users").doc(fireAuth.currentUser!.uid),
      "message_type": messageType.type,
      "last_message": message,
      "time_sent": DateTime.now(),
      "quick_react": "👍",
      "theme": 4289961435,
      "block": false,
      "block_by": "",
    });
  }

  Future<void> updateDataToChatCollection({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
  }) async {
    await fireStore
        .collection("users")
        .doc(fireAuth.currentUser!.uid)
        .collection("chats")
        .doc(receiver_id)
        .update({
      "message_type": messageType.type,
      "last_message": message,
      "time_sent": DateTime.now(),
    });

    await fireStore
        .collection("users")
        .doc(receiver_id)
        .collection("chats")
        .doc(fireAuth.currentUser!.uid)
        .update({
      "message_type": messageType.type,
      "last_message": message,
      "time_sent": DateTime.now(),
    });
  }

  Future<void> saveDataToMessageCollection({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
    required String messageId,
    required ChatReply? chatReply,
  }) async {
    await fireStore
        .collection("users")
        .doc(fireAuth.currentUser!.uid)
        .collection("chats")
        .doc(receiver_id)
        .collection("messages")
        .doc(messageId)
        .set({
      "is_seen": false,
      "message_id": messageId,
      "sender_id": fireAuth.currentUser!.uid,
      "receiver_id": receiver_id,
      "message": message,
      "message_type": messageType.type,
      "time_sent": DateTime.now(),
      "reply_to": chatReply?.toJson(),
    });

    await fireStore
        .collection("users")
        .doc(receiver_id)
        .collection("chats")
        .doc(fireAuth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set({
      "is_seen": false,
      "message_id": messageId,
      "sender_id": fireAuth.currentUser!.uid,
      "receiver_id": receiver_id,
      "message": message,
      "message_type": messageType.type,
      "time_sent": DateTime.now(),
      "reply_to": chatReply?.toJson(),
    });
  }

  Future<void> saveDataToMessageCollectionForFiles({
    required String receiver_id,
    required List<String> message,
    required MessageTypeEnum messageType,
    required String messageId,
  }) async {
    await fireStore
        .collection("users")
        .doc(fireAuth.currentUser!.uid)
        .collection("chats")
        .doc(receiver_id)
        .collection("messages")
        .doc(messageId)
        .set({
      "is_seen": false,
      "message_id": messageId,
      "sender_id": fireAuth.currentUser!.uid,
      "receiver_id": receiver_id,
      "message": message,
      "message_type": messageType.type,
      "time_sent": DateTime.now(),
    });

    await fireStore
        .collection("users")
        .doc(receiver_id)
        .collection("chats")
        .doc(fireAuth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .set({
      "is_seen": false,
      "message_id": messageId,
      "sender_id": fireAuth.currentUser!.uid,
      "receiver_id": receiver_id,
      "message": message,
      "message_type": messageType.type,
      "time_sent": DateTime.now(),
    });
  }

  Future<void> updateDataToMessageCollectionForFiles({
    required String receiver_id,
    required List<String> message,
    required String messageId,
  }) async {
    await fireStore
        .collection("users")
        .doc(fireAuth.currentUser!.uid)
        .collection("chats")
        .doc(receiver_id)
        .collection("messages")
        .doc(messageId)
        .update({
      "message": message,
    });

    await fireStore
        .collection("users")
        .doc(receiver_id)
        .collection("chats")
        .doc(fireAuth.currentUser!.uid)
        .collection("messages")
        .doc(messageId)
        .update({
      "message": message,
    });
  }

  Future<void> checkChatExist({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
  }) async {
    await fireStore
        .collection("users")
        .doc(fireAuth.currentUser!.uid)
        .collection("chats")
        .doc(receiver_id)
        .get()
        .then(
      (value) async {
        if (value.exists) {
          null;
        } else {
          await saveDataToChatCollection(
              receiver_id: receiver_id,
              message: message,
              messageType: messageType);

          final messageId = const Uuid().v1();

          await saveDataToMessageCollection(
            receiver_id: receiver_id,
            message: message,
            messageType: messageType,
            messageId: messageId,
            chatReply: null,
          );
        }
      },
    );
  }

  //
  @override
  Future createChat({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
  }) async {
    try {
      checkChatExist(
          receiver_id: receiver_id, message: message, messageType: messageType);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatList() {
    try {
      return fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("chats")
          .orderBy("time_sent", descending: true)
          .snapshots(includeMetadataChanges: true);
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getChatStream({
    required String receiver_id,
  }) {
    try {
      return fireStore
          .collection('users')
          .doc(fireAuth.currentUser!.uid)
          .collection('chats')
          .doc(receiver_id)
          .collection('messages')
          .orderBy('time_sent', descending: true)
          .snapshots();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future sendTextMessage({
    required String receiver_id,
    required String message,
    required MessageTypeEnum messageType,
    required ChatReply? chatReply,
  }) async {
    try {
      await updateDataToChatCollection(
        receiver_id: receiver_id,
        message: messageType == MessageTypeEnum.location
            ? "🏞️ shared a location"
            : message,
        messageType: messageType,
      );

      final messageId = const Uuid().v1();

      await saveDataToMessageCollection(
        receiver_id: receiver_id,
        message: message,
        messageType: messageType,
        messageId: messageId,
        chatReply: chatReply,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future sendFileMessage({
    required String receiver_id,
    required List<File> fileList,
    required MessageTypeEnum messageType,
  }) async {
    try {
      await updateDataToChatCollection(
        receiver_id: receiver_id,
        message: messageType.name == MessageTypeEnum.image.type
            ? "${fileList.length} x 🏞️"
            : messageType.name == MessageTypeEnum.audio.type
                ? "🎙️ sent a voice"
                : messageType.name == MessageTypeEnum.video.type
                    ? "🎬 sent a video"
                    : "📂 sent a file",
        messageType: messageType,
      );

      final messageId = const Uuid().v1();

      await saveDataToMessageCollectionForFiles(
        receiver_id: receiver_id,
        message: List<String>.generate(fileList.length, (index) => ""),
        messageType: messageType,
        messageId: messageId,
      );

      List<String> imageStringList = await UploadFileListToFireStorage(
        fileList: fileList,
        ref:
            "chat/${messageType.type}/${fireAuth.currentUser!.uid}/$receiver_id/",
        firebaseStorage: firebaseStorage,
      );
      await updateDataToMessageCollectionForFiles(
        receiver_id: receiver_id,
        message: imageStringList,
        messageId: messageId,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future updateTheme({required String receiver_id, required int theme}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("chats")
          .doc(receiver_id)
          .update({
        "theme": theme,
      });

      await fireStore
          .collection("users")
          .doc(receiver_id)
          .collection("chats")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "theme": theme,
      });
      sendTextMessage(
        message: "updated theme",
        messageType: MessageTypeEnum.notification,
        receiver_id: receiver_id,
        chatReply: null,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getChatRoomData(
      {required String chatRoomId}) {
    try {
      return fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("chats")
          .doc(chatRoomId)
          .snapshots();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future updateQuickReaction(
      {required String receiver_id, required String quickReact}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("chats")
          .doc(receiver_id)
          .update({
        "quick_react": quickReact,
      });

      await fireStore
          .collection("users")
          .doc(receiver_id)
          .collection("chats")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "quick_react": quickReact,
      });
      sendTextMessage(
        receiver_id: receiver_id,
        message: 'updated quick react',
        messageType: MessageTypeEnum.notification,
        chatReply: null,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getImagesinChat(
      {required String chatroom_id}) {
    try {
      return fireStore
          .collection('users')
          .doc(fireAuth.currentUser!.uid)
          .collection('chats')
          .doc(chatroom_id)
          .collection('messages')
          .where('message_type', isEqualTo: 'image')
          .snapshots();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getFilesinChat(
      {required String chatroom_id}) {
    try {
      return fireStore
          .collection('users')
          .doc(fireAuth.currentUser!.uid)
          .collection('chats')
          .doc(chatroom_id)
          .collection('messages')
          .where('message_type', isEqualTo: 'file')
          .snapshots();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getVideosinChat(
      {required String chatroom_id}) {
    try {
      return fireStore
          .collection('users')
          .doc(fireAuth.currentUser!.uid)
          .collection('chats')
          .doc(chatroom_id)
          .collection('messages')
          .where('message_type', isEqualTo: 'video')
          .snapshots();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getVoicesinChat(
      {required String chatroom_id}) {
    try {
      return fireStore
          .collection('users')
          .doc(fireAuth.currentUser!.uid)
          .collection('chats')
          .doc(chatroom_id)
          .collection('messages')
          .where('message_type', isEqualTo: 'audio')
          .snapshots();
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future deleteConversation({required String chatroom_id}) async {
    try {
      // For sender

      QuerySnapshot senderQuerySnapshot = await fireStore
          .collection('users')
          .doc(fireAuth.currentUser!.uid)
          .collection('chats')
          .doc(chatroom_id)
          .collection('messages')
          .get();

      WriteBatch senderBatch = fireStore.batch();

      for (QueryDocumentSnapshot document in senderQuerySnapshot.docs) {
        senderBatch.delete(document.reference);
      }

      await senderBatch.commit();

      // For receiver

      QuerySnapshot receiverQuerySnapshot = await fireStore
          .collection('users')
          .doc(chatroom_id)
          .collection('chats')
          .doc(fireAuth.currentUser!.uid)
          .collection('messages')
          .get();

      WriteBatch receiverBatch = fireStore.batch();

      for (QueryDocumentSnapshot document in receiverQuerySnapshot.docs) {
        receiverBatch.delete(document.reference);
      }

      await receiverBatch.commit();
      sendTextMessage(
        receiver_id: chatroom_id,
        message: "deleted chat history",
        messageType: MessageTypeEnum.notification,
        chatReply: null,
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future<bool> blockUser(
      {required String receiver_id, required bool is_block}) async {
    try {
      await fireStore
          .collection("users")
          .doc(fireAuth.currentUser!.uid)
          .collection("chats")
          .doc(receiver_id)
          .update({
        "block": is_block,
        "block_by": is_block ? fireAuth.currentUser!.uid : "",
      });

      await fireStore
          .collection("users")
          .doc(receiver_id)
          .collection("chats")
          .doc(fireAuth.currentUser!.uid)
          .update({
        "block": is_block,
        "block_by": is_block ? fireAuth.currentUser!.uid : "",
      });
      return is_block;
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Future addStory({required String image}) async {
    try {
      final id = const Uuid().v1();
      await UploadImageToFireStorage(
        imageFile: File(image),
        ref: "storyImages/${fireAuth.currentUser!.uid}/$id",
        firebaseStorage: firebaseStorage,
      ).then(
        (value) async {
          // Story
          StoryBody newStoryBody = StoryBody(
            image: value,
            created_at: DateTime.now(),
          );
          Story newStory = Story(
            story_owner_id: fireAuth.currentUser!.uid,
            stories: [],
          );

          //
          DocumentReference docRef =
              fireStore.collection('stories').doc(fireAuth.currentUser!.uid);

          final docSnapshot = await docRef.get();

          if (docSnapshot.exists) {
            await docRef.update({
              'stories': FieldValue.arrayUnion([newStoryBody.toJson()]),
            });
          } else {
            await docRef.set(newStory.toJson());

            await docRef.update({
              'stories': FieldValue.arrayUnion([newStoryBody.toJson()]),
            });
          }
        },
      );
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }

  @override
  Stream<List<Story>> getAllStories() {
    try {
      return fireStore.collection("stories").snapshots().map(
          (event) => event.docs.map((e) => Story.fromJson(e.data())).toList());
    } on FirebaseAuthException catch (e) {
      throw ServerException(e.message!);
    } catch (e) {
      throw ServerException('$e');
    }
  }
}
