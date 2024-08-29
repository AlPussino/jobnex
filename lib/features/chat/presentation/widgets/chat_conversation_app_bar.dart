import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/core/util/change_to_time_ago.dart';

class ChatConversationAppBar extends StatelessWidget {
  final Map<String, dynamic> receiverData;

  final Map<String, dynamic> chatRoomData;
  final Size size;
  const ChatConversationAppBar({
    super.key,
    required this.receiverData,
    required this.chatRoomData,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 18,
            backgroundImage:
                CachedNetworkImageProvider(receiverData['profile_url']),
          ),
          CircleAvatar(
            radius: 6,
            child: CircleAvatar(
              radius: 4,
              backgroundColor: receiverData['is_online']
                  ? AppPallete.green
                  : AppPallete.grey,
            ),
          )
        ],
      ),
      title: Text(receiverData['name']),
      subtitle: Text(
        receiverData['is_online']
            ? "online"
            : changeToTimeAgo(chatRoomData['last_online']),
      ),
    );
  }
}
