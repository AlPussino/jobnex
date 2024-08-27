import 'package:flutter/material.dart';
import 'package:freezed_example/core/common/enum/message_type_enum.dart';
import 'package:freezed_example/features/chat/presentation/widgets/audio_message.dart';
import 'package:freezed_example/features/chat/presentation/widgets/emoji_message.dart';
import 'package:freezed_example/features/chat/presentation/widgets/file_message.dart';
import 'package:freezed_example/features/chat/presentation/widgets/images_message.dart';
import 'package:freezed_example/features/chat/presentation/widgets/location_message.dart';
import 'package:freezed_example/features/chat/presentation/widgets/notification_message.dart';
import 'package:freezed_example/features/chat/presentation/widgets/text_message.dart';
import 'package:freezed_example/features/chat/presentation/widgets/video_message.dart';

class MessageBox extends StatelessWidget {
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;
  const MessageBox(
      {super.key, required this.chatData, required this.chatListData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: buildMessageWidget(chatData, size, chatListData),
    );
  }
}

Widget buildMessageWidget(
    Map<String, dynamic> chatData, Size size, dynamic chatListData) {
  // change string into Enum
  final messageType = (chatData['message_type'] as String).toEnum();
  switch (messageType) {
    case MessageTypeEnum.text:
      return TextMessage(
        size: size,
        chatData: chatData,
        chatListData: chatListData,
      );

    case MessageTypeEnum.image:
      return ImagesMessage(
        size: size,
        chatData: chatData,
        chatListData: chatListData,
      );
    case MessageTypeEnum.audio:
      return AudioMessage(
        size: size,
        chatData: chatData,
        chatListData: chatListData,
      );
    case MessageTypeEnum.file:
      return FileMessage(
        size: size,
        chatData: chatData,
        chatListData: chatListData,
      );
    case MessageTypeEnum.video:
      return VideoMessage(
          size: size, chatData: chatData, chatListData: chatListData);
    case MessageTypeEnum.location:
      return LocationMessage(
          size: size, chatData: chatData, chatListData: chatListData);
    case MessageTypeEnum.emoji:
      return EmojiMessage(
          size: size, chatData: chatData, chatListData: chatListData);
    case MessageTypeEnum.notification:
      return NotificationMessage(message: chatData['message']);
    default:
      return const SizedBox.shrink();
  }
}
