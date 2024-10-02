import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/download_file.dart';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class PreviewReplyFileWidget extends StatelessWidget {
  final Map<String, dynamic> receiverData;

  const PreviewReplyFileWidget({super.key, required this.receiverData});

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
                BuildFilePreviewReplyWidget(chatReply: chatReply),
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

class BuildFilePreviewReplyWidget extends StatefulWidget {
  final ChatReply chatReply;
  const BuildFilePreviewReplyWidget({super.key, required this.chatReply});

  @override
  State<BuildFilePreviewReplyWidget> createState() =>
      _BuildFilePreviewReplyWidgetState();
}

class _BuildFilePreviewReplyWidgetState
    extends State<BuildFilePreviewReplyWidget> {
  bool isDownloading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Card(
      color: Theme.of(context).canvasColor,
      child: Container(
        width: size.width / 1.5,
        height: size.height / 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: widget.chatReply.message == ""
              ? const LoadingWidget()
              : SizedBox(
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              isDownloading = true;
                            });
                            downloadFile(context, widget.chatReply.message)
                                .then(
                              (value) {
                                setState(() {
                                  isDownloading = false;
                                });
                              },
                            );
                          },
                          child: CircleAvatar(
                              radius: double.infinity,
                              child: isDownloading
                                  ? const LoadingWidget()
                                  : const Icon(Iconsax.document_download_bold)),
                        ),
                      ),
                      SizedBox(width: size.width / 20),
                      Expanded(
                        flex: 4,
                        child: Text(
                          widget.chatReply.message,
                          softWrap: true,
                          overflow: TextOverflow.fade,
                          maxLines: 2,
                          style: Theme.of(context).primaryTextTheme.bodySmall,
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
