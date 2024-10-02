import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

class LocationMessage extends StatelessWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;

  const LocationMessage({
    super.key,
    required this.size,
    required this.chatData,
    required this.chatListData,
  });

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;

    void openMap(
        {required double latitude,
        required double longitude,
        required String addressTitle}) async {
      final availableMaps = await MapLauncher.installedMaps;
      await availableMaps.first.showMarker(
        coords: Coords(latitude, longitude),
        title: addressTitle,
      );
    }

    final latitude = (chatData['message'] as String).split("@").first;
    final longitude = (chatData['message'] as String).split("@")[1];
    final addressTitle = (chatData['message'] as String).split("@").last;

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
                message_type: MessageTypeEnum.location.name,
                message_owner_id: chatData['sender_id'],
              ),
            );
      },
      onLeftSwipe: (details) {
        context.read<ChatInputProvider>().replyMessage(
              ChatReply(
                message: chatData['message'],
                message_type: MessageTypeEnum.location.name,
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
            width: size.width / 2,
            height: size.height / 12,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () => openMap(
                      latitude: double.parse(latitude),
                      longitude: double.parse(longitude),
                      addressTitle: addressTitle,
                    ),
                    icon: const Icon(Iconsax.location_bold),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Text(
                    addressTitle,
                    softWrap: true,
                    maxLines: 1,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
