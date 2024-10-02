import 'package:JobNex/core/common/widget/cached_network_image_widget.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PreviewReplyImageWidget extends StatelessWidget {
  final Map<String, dynamic> receiverData;

  const PreviewReplyImageWidget({super.key, required this.receiverData});

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
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                chatReply.message_owner_id == fireAuth.currentUser!.uid
                    ? "replying to your message"
                    : "replying to ${receiverData['name']}'s message",
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: size.height / 6,
                  maxWidth: size.width / 2,
                ),
                child: CachedNetworkImageWidget(imageUrl: chatReply.message),
              ),
            ],
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
