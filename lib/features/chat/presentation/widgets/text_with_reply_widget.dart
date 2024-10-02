import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/features/chat/presentation/widgets/text_with_file_reply_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/text_with_image_reply_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/text_with_location_reply_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/text_with_text_reply_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/text_with_video_reply_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/text_with_voice_reply_widget.dart';
import 'package:flutter/material.dart';

class TextWithReplyWidget extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;

  const TextWithReplyWidget({
    super.key,
    required this.size,
    required this.chatData,
    required this.chatListData,
  });

  @override
  Widget build(BuildContext context) {
    final messageType =
        ((chatData['reply_to']['message_type']) as String).toEnum();

    switch (messageType) {
      case MessageTypeEnum.text:
        return TextWithTextReplyWidget(
            size: size, chatData: chatData, chatListData: chatListData);

      case MessageTypeEnum.image:
        return TextWithImageReplyWidget(
            size: size, chatData: chatData, chatListData: chatListData);

      case MessageTypeEnum.audio:
        return TextWithVoiceReplyWidget(
            size: size, chatData: chatData, chatListData: chatListData);

      case MessageTypeEnum.video:
        return TextWithVideoReplyWidget(
            size: size, chatData: chatData, chatListData: chatListData);

      case MessageTypeEnum.file:
        return TextWithFileReplyWidget(
            size: size, chatData: chatData, chatListData: chatListData);

      case MessageTypeEnum.location:
        return TextWithLocationReplyWidget(
            size: size, chatData: chatData, chatListData: chatListData);

      case MessageTypeEnum.emoji:
        return TextWithTextReplyWidget(
            size: size, chatData: chatData, chatListData: chatListData);

      default:
        return const Text("Default");
    }
  }
}
