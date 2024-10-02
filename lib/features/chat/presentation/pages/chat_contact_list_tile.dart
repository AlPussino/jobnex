import 'package:JobNex/core/common/widget/cached_network_image_widget.dart';
import 'package:animate_do/animate_do.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:JobNex/core/common/widget/shimmer_list_tile.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/core/util/change_to_time_ago.dart';
import 'package:JobNex/features/chat/presentation/pages/chat_conversation_page.dart';

class ChatContactListTile extends StatelessWidget {
  final DocumentReference<Map<String, dynamic>> chatSnapshot;
  final String lastMessage;
  final int index;

  const ChatContactListTile({
    super.key,
    required this.chatSnapshot,
    required this.lastMessage,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return AnimationConfiguration.staggeredList(
      position: index,
      delay: const Duration(milliseconds: 100),
      child: SlideAnimation(
        horizontalOffset: 30,
        verticalOffset: 300,
        duration: const Duration(milliseconds: 2500),
        curve: Curves.fastLinearToSlowEaseIn,
        child: FlipAnimation(
          duration: const Duration(milliseconds: 3000),
          curve: Curves.fastLinearToSlowEaseIn,
          flipAxis: FlipAxis.y,
          child: FadeInUp(
            from: index * 10,
            duration: const Duration(milliseconds: 100),
            delay: const Duration(milliseconds: 100),
            animate: true,
            curve: Curves.bounceIn,
            child: StreamBuilder(
              stream: chatSnapshot.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const ShimmerListTile();
                } else if (snapshot.hasError) {
                  return Center(child: Text("${snapshot.error}"));
                }
                final chatContact = snapshot.data!;
                return InkWell(
                  highlightColor: AppPallete.lightBlue,
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      ChatConversationPage.routeName,
                      arguments: {
                        "receiverData": chatContact.data(),
                        "chatRoomId": chatContact.id,
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: ListTile(
                      leading: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 25,
                            child: CircleAvatar(
                              radius: 25,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: CachedNetworkImageWidget(
                                  imageUrl: chatContact['profile_url'],
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 8,
                            child: CircleAvatar(
                              radius: 6,
                              backgroundColor: chatContact['is_online']
                                  ? AppPallete.green
                                  : AppPallete.grey,
                            ),
                          )
                        ],
                      ),
                      title: Text(
                        chatContact['name'],
                        style: Theme.of(context).primaryTextTheme.titleMedium,
                      ),
                      subtitle: Text(
                        lastMessage,
                        maxLines: 2,
                        style: Theme.of(context).primaryTextTheme.bodySmall,
                      ),
                      trailing: Text(
                        chatContact['is_online']
                            ? "online"
                            : changeToTimeAgo(
                                chatContact['last_online'],
                              ),
                        style: Theme.of(context).primaryTextTheme.bodySmall,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ).animate(delay: const Duration(seconds: 2)).shimmer(),
    );
  }
}
