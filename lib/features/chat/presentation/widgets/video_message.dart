import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/common/widget/video_widget.dart';

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
          width: size.width / 1.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            child: chatData['message'][0] == ""
                ? const LoadingWidget()
                : VideoWidget(videoUrl: chatData['message'][0]),
          ),
        ),
      ),
    );
  }
}
