part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class ChatCreateChat extends ChatEvent {
  final String receiver_id;
  final String message;
  final MessageTypeEnum messageType;
  ChatCreateChat(this.receiver_id, this.message, this.messageType);
}

final class ChatGetChatList extends ChatEvent {}

final class ChatGetChatMessages extends ChatEvent {
  final String receiver_id;
  ChatGetChatMessages(this.receiver_id);
}

final class ChatSendTextMessage extends ChatEvent {
  final String receiver_id;
  final String message;
  final MessageTypeEnum messageType;
  final ChatReply? chatReply;
  ChatSendTextMessage(
    this.receiver_id,
    this.message,
    this.messageType,
    this.chatReply,
  );
}

final class ChatSendFileMessage extends ChatEvent {
  final String receiver_id;
  final List<File> fileList;
  final MessageTypeEnum messageType;
  ChatSendFileMessage(this.receiver_id, this.fileList, this.messageType);
}

final class ChatGetChatRoomData extends ChatEvent {
  final String chatRoomId;
  ChatGetChatRoomData(this.chatRoomId);
}

final class ChatUpdateTheme extends ChatEvent {
  final String receiver_id;
  final int theme;
  ChatUpdateTheme(this.receiver_id, this.theme);
}

final class ChatUpdateQuickReaction extends ChatEvent {
  final String receiver_id;
  final String quickReact;
  ChatUpdateQuickReaction(this.receiver_id, this.quickReact);
}

final class ChatGetImagesInChat extends ChatEvent {
  final String chatroom_id;
  ChatGetImagesInChat(this.chatroom_id);
}

final class ChatGetVideosInChat extends ChatEvent {
  final String chatroom_id;
  ChatGetVideosInChat(this.chatroom_id);
}

final class ChatGetVoicesInChat extends ChatEvent {
  final String chatroom_id;
  ChatGetVoicesInChat(this.chatroom_id);
}

final class ChatGetFilesInChat extends ChatEvent {
  final String chatroom_id;
  ChatGetFilesInChat(this.chatroom_id);
}

final class ChatDeleteConversation extends ChatEvent {
  final String chatroom_id;
  ChatDeleteConversation(this.chatroom_id);
}

final class ChatBlockUser extends ChatEvent {
  final String receiver_id;
  final bool is_block;
  ChatBlockUser(this.receiver_id, this.is_block);
}

final class ChatAddStory extends ChatEvent {
  final String image;
  ChatAddStory(this.image);
}

final class ChatGetAllStories extends ChatEvent {}
