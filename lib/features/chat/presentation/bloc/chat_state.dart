part of 'chat_bloc.dart';

@immutable
sealed class ChatState {
  const ChatState();
}

final class ChatInitial extends ChatState {}

final class ChatLoading extends ChatState {}

final class ChatFailure extends ChatState {
  final String message;
  const ChatFailure(this.message);
}

final class ChatCreatChatsuccess extends ChatState {}

final class ChatGetChatListSuccess extends ChatState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> chatList;
  const ChatGetChatListSuccess(this.chatList);
}

final class ChatGetChatMessagesSuccess extends ChatState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> chatStream;
  const ChatGetChatMessagesSuccess(this.chatStream);
}

final class ChatSendTextMessagesSuccess extends ChatState {}

final class ChatSendFileMessagesSuccess extends ChatState {}

final class ChatGetChatRoomDataSuccuess extends ChatState {
  final Stream<DocumentSnapshot<Map<String, dynamic>>> chatRoomData;
  const ChatGetChatRoomDataSuccuess(this.chatRoomData);
}

final class ChatUpdateThemeSuccess extends ChatState {}

final class ChatUpdateQuickReactionSuccess extends ChatState {}

final class ChatGetImagesInChatSuccess extends ChatState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> images;
  const ChatGetImagesInChatSuccess(this.images);
}

final class ChatGetVideosInChatSuccess extends ChatState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> videos;
  const ChatGetVideosInChatSuccess(this.videos);
}

final class ChatGetVoicesInChatSuccess extends ChatState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> voices;
  const ChatGetVoicesInChatSuccess(this.voices);
}

final class ChatGetFilesInChatSuccess extends ChatState {
  final Stream<QuerySnapshot<Map<String, dynamic>>> files;
  const ChatGetFilesInChatSuccess(this.files);
}

final class ChatDeleteConversationSuccess extends ChatState {}

final class ChatBlockUserSuccess extends ChatState {
  final bool is_block;
  const ChatBlockUserSuccess(this.is_block);
}
