import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/usecase/usecase.dart';
import 'package:JobNex/features/chat/data/model/story.dart';
import 'package:JobNex/features/chat/domain/usecase/add_story.dart';
import 'package:JobNex/features/chat/domain/usecase/create_chat.dart';
import 'package:JobNex/features/chat/domain/usecase/delete_conversation.dart';
import 'package:JobNex/features/chat/domain/usecase/get_all_stories.dart';
import 'package:JobNex/features/chat/domain/usecase/get_chat_list.dart';
import 'package:JobNex/features/chat/domain/usecase/get_chatroom_data.dart';
import 'package:JobNex/features/chat/domain/usecase/get_files_in_chat.dart';
import 'package:JobNex/features/chat/domain/usecase/get_images_in_chat.dart';
import 'package:JobNex/features/chat/domain/usecase/get_videos_in_chat.dart';
import 'package:JobNex/features/chat/domain/usecase/get_voices_in_chat.dart';
import 'package:JobNex/features/chat/domain/usecase/send_text_message.dart';
import 'package:JobNex/features/chat/domain/usecase/update_theme.dart';
import '../../data/model/chat_reply.dart';
import '../../domain/usecase/block_user.dart';
import '../../domain/usecase/get_chat_stream.dart';
import '../../domain/usecase/send_file_message.dart';
import '../../domain/usecase/update_quick_reaction.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final CreateChat _createChat;
  final GetChatList _getChatList;
  final GetChatStream _getChatStream;
  final SendTextMessage _sendTextMessage;
  final SendFileMessage _sendFileMessage;
  final UpdateTheme _updateTheme;
  final GetChatroomData _getChatroomData;
  final UpdateQuickReaction _updateQuickReaction;
  final GetImagesInChat _getImagesInChat;
  final GetVideosInChat _getVideosInChat;
  final GetVoicesInChat _getVoicesInChat;
  final GetFilesInChat _getFilesInChat;
  final DeleteConversation _deleteConversation;
  final BlockUser _blockUser;
  final AddStory _addStory;
  final GetAllStories _getAllStories;

  ChatBloc({
    required CreateChat createChat,
    required GetChatList getChatList,
    required GetChatStream getChatStream,
    required SendTextMessage sendTextMessage,
    required SendFileMessage sendFileMessage,
    required UpdateTheme updateTheme,
    required GetChatroomData getChatRoomData,
    required UpdateQuickReaction updateQuickReaction,
    required GetImagesInChat getImagesInChat,
    required GetVideosInChat getVideosInChat,
    required GetVoicesInChat getVoicesInChat,
    required GetFilesInChat getFilesInChat,
    required DeleteConversation deleteConversation,
    required BlockUser blockUser,
    required AddStory addStory,
    required GetAllStories getAllStories,
  })  : _createChat = createChat,
        _getChatList = getChatList,
        _getChatStream = getChatStream,
        _sendTextMessage = sendTextMessage,
        _sendFileMessage = sendFileMessage,
        _updateTheme = updateTheme,
        _getChatroomData = getChatRoomData,
        _updateQuickReaction = updateQuickReaction,
        _getImagesInChat = getImagesInChat,
        _getVideosInChat = getVideosInChat,
        _getVoicesInChat = getVoicesInChat,
        _getFilesInChat = getFilesInChat,
        _deleteConversation = deleteConversation,
        _blockUser = blockUser,
        _addStory = addStory,
        _getAllStories = getAllStories,
        super(ChatInitial()) {
    on<ChatEvent>((_, emit) => emit(ChatLoading()));
    on<ChatCreateChat>(onChatCreateChat);
    on<ChatGetChatList>(onChatGetChatList);
    on<ChatGetChatMessages>(onChatGetChatMessages);
    on<ChatSendTextMessage>(onChatSendTextMessage);
    on<ChatSendFileMessage>(onChatSendFileMessage);
    on<ChatUpdateTheme>(onChatUpdateTheme);
    on<ChatGetChatRoomData>(onChatGetChatChatRoomData);
    on<ChatUpdateQuickReaction>(onChatUpdateQuickReaction);
    on<ChatGetImagesInChat>(onChatGetImagesInChat);
    on<ChatGetVideosInChat>(onChatGetVideosInChat);
    on<ChatGetVoicesInChat>(onChatGetVoicesInChat);
    on<ChatGetFilesInChat>(onChatGetFilesInChat);
    on<ChatDeleteConversation>(onChatDeleteConversation);
    on<ChatBlockUser>(onChatBlockUser);
    on<ChatAddStory>(onChatAddStory);
    on<ChatGetAllStories>(onChatGetAllStories);
  }

  void onChatCreateChat(ChatCreateChat event, Emitter<ChatState> emit) async {
    final response = await _createChat.call(CreateChatParams(
        receiver_id: event.receiver_id,
        message: event.message,
        messageType: event.messageType));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (_) => emit(ChatCreatChatsuccess()));
  }

  void onChatGetChatList(ChatGetChatList event, Emitter<ChatState> emit) async {
    final response = await _getChatList.call(NoParams());
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (chatList) => emit(ChatGetChatListSuccess(chatList)));
    // (chatList) => emit(ChatLoading()));
  }

  void onChatGetChatMessages(
      ChatGetChatMessages event, Emitter<ChatState> emit) async {
    final response = await _getChatStream
        .call(GetChatStreamParams(receiver_id: event.receiver_id));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (chatStream) => emit(ChatGetChatMessagesSuccess(chatStream)));
  }

  void onChatSendTextMessage(
      ChatSendTextMessage event, Emitter<ChatState> emit) async {
    final response = await _sendTextMessage.call(SendTextMessageParams(
      receiver_id: event.receiver_id,
      message: event.message,
      messageType: event.messageType,
      chatReply: event.chatReply,
    ));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (chatStream) => emit(ChatSendTextMessagesSuccess()));
  }

  void onChatSendFileMessage(
      ChatSendFileMessage event, Emitter<ChatState> emit) async {
    final response = await _sendFileMessage.call(SendFileMessageParams(
        receiver_id: event.receiver_id,
        fileList: event.fileList,
        messageType: event.messageType));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (chatStream) => emit(ChatSendFileMessagesSuccess()));
  }

  void onChatUpdateTheme(ChatUpdateTheme event, Emitter<ChatState> emit) async {
    final response = await _updateTheme.call(
        UpdateThemeParams(receiver_id: event.receiver_id, theme: event.theme));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (_) => emit(ChatUpdateThemeSuccess()));
  }

  void onChatGetChatChatRoomData(
      ChatGetChatRoomData event, Emitter<ChatState> emit) async {
    final response = await _getChatroomData
        .call(GetChatRoomDataParams(chatRoomId: event.chatRoomId));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (chatData) => emit(ChatGetChatRoomDataSuccuess(chatData)));
  }

  void onChatUpdateQuickReaction(
      ChatUpdateQuickReaction event, Emitter<ChatState> emit) async {
    final response = await _updateQuickReaction.call(UpdateQuickReactionParams(
        receiver_id: event.receiver_id, quickReact: event.quickReact));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (_) => emit(ChatUpdateQuickReactionSuccess()));
  }

  void onChatGetImagesInChat(
      ChatGetImagesInChat event, Emitter<ChatState> emit) async {
    final response = await _getImagesInChat
        .call(GetImagesInChatParams(chatroom_id: event.chatroom_id));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (images) => emit(ChatGetImagesInChatSuccess(images)));
  }

  void onChatGetVideosInChat(
      ChatGetVideosInChat event, Emitter<ChatState> emit) async {
    final response = await _getVideosInChat
        .call(GetVideosInChatParams(chatroom_id: event.chatroom_id));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (videos) => emit(ChatGetVideosInChatSuccess(videos)));
  }

  void onChatGetVoicesInChat(
      ChatGetVoicesInChat event, Emitter<ChatState> emit) async {
    final response = await _getVoicesInChat
        .call(GetVoicesInChatParams(chatroom_id: event.chatroom_id));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (voices) => emit(ChatGetVoicesInChatSuccess(voices)));
  }

  void onChatGetFilesInChat(
      ChatGetFilesInChat event, Emitter<ChatState> emit) async {
    final response = await _getFilesInChat
        .call(GetFilesInChatParams(chatroom_id: event.chatroom_id));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (files) => emit(ChatGetFilesInChatSuccess(files)));
  }

  void onChatDeleteConversation(
      ChatDeleteConversation event, Emitter<ChatState> emit) async {
    final response = await _deleteConversation
        .call(DeleteConversationParams(chatroom_id: event.chatroom_id));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (_) => emit(ChatDeleteConversationSuccess()));
  }

  void onChatBlockUser(ChatBlockUser event, Emitter<ChatState> emit) async {
    final response = await _blockUser.call(BlockUserParams(
        receiver_id: event.receiver_id, is_block: event.is_block));
    response.fold((failure) => emit(ChatFailure(failure.message)),
        (is_block) => emit(ChatBlockUserSuccess(is_block)));
  }

  void onChatAddStory(ChatAddStory event, Emitter<ChatState> emit) async {
    final response = await _addStory.call(AddStoryParams(image: event.image));

    response.fold((failure) => emit(ChatFailure(failure.message)),
        (_) => emit(ChatAddStorySuccess()));
  }

  void onChatGetAllStories(
      ChatGetAllStories event, Emitter<ChatState> emit) async {
    final response = await _getAllStories.call(NoParams());

    response.fold((failure) => emit(ChatFailure(failure.message)),
        (stories) => emit(ChatGetAllStoriesSuccess(stories: stories)));
  }
}
