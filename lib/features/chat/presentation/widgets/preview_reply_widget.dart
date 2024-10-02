import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/features/chat/presentation/widgets/preview_reply_audio_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/preview_reply_emoji_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/preview_reply_file_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/preview_reply_image_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/preview_reply_location_widget.dart';
import 'package:JobNex/features/chat/presentation/widgets/preview_reply_text_widget.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:JobNex/features/chat/presentation/widgets/preview_reply_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewReplyWidget extends StatelessWidget {
  final Map<String, dynamic> receiverData;
  const PreviewReplyWidget({super.key, required this.receiverData});

  @override
  Widget build(BuildContext context) {
    // No Reply
    if (context.watch<ChatInputProvider>().reply == null) {
      return const SizedBox.shrink();
    }
    // Reply
    else {
      final messageType =
          (context.watch<ChatInputProvider>().reply!.message_type).toEnum();
      switch (messageType) {
        case MessageTypeEnum.text:
          return PreviewReplyTextWidget(receiverData: receiverData);

        case MessageTypeEnum.image:
          return PreviewReplyImageWidget(receiverData: receiverData);

        case MessageTypeEnum.audio:
          return PreviewReplyAudioWidget(receiverData: receiverData);

        case MessageTypeEnum.video:
          return PreviewReplyVideoWidget(receiverData: receiverData);

        case MessageTypeEnum.file:
          return PreviewReplyFileWidget(receiverData: receiverData);

        case MessageTypeEnum.location:
          return PreviewReplyLocationWidget(receiverData: receiverData);

        case MessageTypeEnum.emoji:
          return PreviewReplyEmojiWidgets(receiverData: receiverData);

        default:
          return const Text("Default");
      }
    }
  }
}
