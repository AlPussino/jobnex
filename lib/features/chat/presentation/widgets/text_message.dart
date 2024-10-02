import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:JobNex/features/chat/presentation/widgets/text_with_reply_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:swipe_to/swipe_to.dart';

class TextMessage extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;

  const TextMessage({
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
                message: chatData['message'],
                message_type: MessageTypeEnum.text.name,
                message_owner_id: chatData['sender_id'],
              ),
            );
      },
      onLeftSwipe: (details) {
        context.read<ChatInputProvider>().replyMessage(
              ChatReply(
                message: chatData['message'],
                message_type: MessageTypeEnum.text.name,
                message_owner_id: chatData['sender_id'],
              ),
            );
      },
      child: Container(
        width: size.width,
        padding: const EdgeInsets.only(bottom: 20),
        alignment: chatData['sender_id'] == fireAuth.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: chatData['reply_to'] != null
            // Reply
            //
            ? TextWithReplyWidget(
                chatData: chatData,
                chatListData: chatListData,
                size: size,
              )
            :

            // No Reply

            //
            Padding(
                padding: chatData['sender_id'] == fireAuth.currentUser!.uid
                    ? const EdgeInsets.only(left: 20)
                    : const EdgeInsets.only(right: 20),
                child: Card(
                  color: chatData['sender_id'] == fireAuth.currentUser!.uid
                      ? Color(chatListData['theme'])
                      : null,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      chatData['message'],
                      style: Theme.of(context).primaryTextTheme.titleSmall,
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
