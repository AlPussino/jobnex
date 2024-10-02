import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:provider/provider.dart';

class PreviewReplyLocationWidget extends StatelessWidget {
  final Map<String, dynamic> receiverData;

  const PreviewReplyLocationWidget({super.key, required this.receiverData});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    final size = MediaQuery.sizeOf(context);
    final chatReply = context.watch<ChatInputProvider>().reply!;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).shadowColor,
      ),
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
                BuildLocationPreviewReplyWidget(chatReply: chatReply),
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

class BuildLocationPreviewReplyWidget extends StatelessWidget {
  final ChatReply chatReply;
  const BuildLocationPreviewReplyWidget({super.key, required this.chatReply});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    void openMap({
      required double latitude,
      required double longitude,
      required String addressTitle,
    }) async {
      final availableMaps = await MapLauncher.installedMaps;
      await availableMaps.first.showMarker(
        coords: Coords(latitude, longitude),
        title: addressTitle,
      );
    }

    final latitude = (chatReply.message).split("@").first;
    final longitude = (chatReply.message).split("@")[1];
    final addressTitle = (chatReply.message).split("@").last;

    return Card(
      color: Theme.of(context).canvasColor,
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
    );
  }
}
