import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:JobNex/features/chat/presentation/widgets/video_thumbnail_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

class VideoMessage extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;

  const VideoMessage({
    super.key,
    required this.size,
    required this.chatData,
    required this.chatListData,
  });

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;

    return SwipeTo(
      key: UniqueKey(),
      offsetDx: 0.2,
      swipeSensitivity: 8,
      iconColor: AppPallete.lightBlue,
      animationDuration: const Duration(milliseconds: 100),
      onRightSwipe: (details) {
        context.read<ChatInputProvider>().replyMessage(
              ChatReply(
                message: chatData['message'][0],
                message_type: MessageTypeEnum.video.name,
                message_owner_id: chatData['sender_id'],
              ),
            );
      },
      onLeftSwipe: (details) {
        context.read<ChatInputProvider>().replyMessage(
              ChatReply(
                message: chatData['message'][0],
                message_type: MessageTypeEnum.video.name,
                message_owner_id: chatData['sender_id'],
              ),
            );
      },
      child: Container(
        width: size.width,
        alignment: chatData['sender_id'] == fireAuth.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Card(
          color: chatData['sender_id'] == fireAuth.currentUser!.uid
              ? Color(chatListData['theme'])
              : null,
          child: Container(
            width: size.width / 1.3,
            height: size.height / 4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: chatData['message'][0] == ""
                  ? const LoadingWidget()
                  // : VideoWidget(videoUrl: chatData['message'][0]),
                  : VideoThumbnailImage(
                      videoUrl: chatData['message'][0],
                      isChat: true,
                    ),
              // child: Text("FUCK"),
            ),
          ),
        ),
      ),
    );
  }
}
