import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: size.width,
      alignment: chatData['sender_id'] == fireAuth.currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Card(
        color: chatData['sender_id'] == fireAuth.currentUser!.uid
            ? Color(chatListData['theme'])
            : null,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(
              chatData['message'],
            ),
          ),
        ),
      ),
    );
  }
}
