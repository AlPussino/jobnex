import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/util/download_file.dart';
import 'package:icons_plus/icons_plus.dart';

class FileMessage extends StatefulWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;

  const FileMessage({
    super.key,
    required this.size,
    required this.chatData,
    required this.chatListData,
  });

  @override
  State<FileMessage> createState() => _FileMessageState();
}

class _FileMessageState extends State<FileMessage> {
  bool isDownloading = false;
  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    return Container(
      width: widget.size.width,
      alignment: widget.chatData['sender_id'] == fireAuth.currentUser!.uid
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Card(
        color: widget.chatData['sender_id'] == fireAuth.currentUser!.uid
            ? Color(widget.chatListData['theme'])
            : null,
        child: Container(
          width: widget.size.width / 1.5,
          height: widget.size.height / 13,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: widget.chatData['message'][0] == ""
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
                              downloadFile(
                                      context, widget.chatData['message'][0])
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
                                    : const Icon(
                                        Iconsax.document_download_bold)),
                          ),
                        ),
                        SizedBox(width: widget.size.width / 10),
                        Expanded(
                          flex: 4,
                          child: Text(
                            widget.chatData['message'][0],
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
      ),
    );
  }
}
