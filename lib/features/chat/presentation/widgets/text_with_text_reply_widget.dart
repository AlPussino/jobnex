import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class TextWithTextReplyWidget extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;
  const TextWithTextReplyWidget({
    super.key,
    required this.size,
    required this.chatData,
    required this.chatListData,
  });

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;

    return Padding(
      padding: chatData['sender_id'] == fireAuth.currentUser!.uid
          ? const EdgeInsets.only(left: 20)
          : const EdgeInsets.only(right: 20),
      child: Column(
        crossAxisAlignment: chatData['sender_id'] == fireAuth.currentUser!.uid
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Theme.of(context).highlightColor,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(10),
                topRight: const Radius.circular(10),
                bottomLeft: chatData['sender_id'] == fireAuth.currentUser!.uid
                    ? const Radius.circular(10)
                    : const Radius.circular(0),
                bottomRight: chatData['sender_id'] == fireAuth.currentUser!.uid
                    ? const Radius.circular(0)
                    : const Radius.circular(10),
              ),
            ),
            child: Text(
              chatData['reply_to']['message'],
              maxLines: 1,
            ),
          ),
          Card(
            color: chatData['sender_id'] == fireAuth.currentUser!.uid
                ? Color(chatListData['theme'])
                : null,
            child: Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              child: Text(
                chatData['message'],
                style: Theme.of(context).primaryTextTheme.titleSmall,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
