import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewReplyEmojiWidgets extends StatelessWidget {
  final Map<String, dynamic> receiverData;

  const PreviewReplyEmojiWidgets({super.key, required this.receiverData});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    final size = MediaQuery.sizeOf(context);
    final chatReply = context.watch<ChatInputProvider>().reply!;
    return Container(
      width: size.width,
      decoration: BoxDecoration(color: Theme.of(context).shadowColor),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatReply.message_owner_id == fireAuth.currentUser!.uid
                      ? "replying to your message"
                      : "replying to ${receiverData['name']}'s message",
                ),
                Text(
                  chatReply.message,
                  style: Theme.of(context).primaryTextTheme.titleLarge,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<ChatInputProvider>().clearReply();
            },
            icon: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }
}
