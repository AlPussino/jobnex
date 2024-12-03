import 'dart:developer';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/config/agora_config.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VideoCallingPage extends StatefulWidget {
  final String receiver_id;
  final String channel;
  const VideoCallingPage(
      {super.key, required this.receiver_id, required this.channel});

  @override
  State<VideoCallingPage> createState() => _VideoCallingPageState();
}

class _VideoCallingPageState extends State<VideoCallingPage> {
  AgoraClient? agoraClient;
  String baseUr = "https://flutter-twitch-server1.onrender.com";
  bool showButtons = true;
  final fireAuth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  @override
  void initState() {
    initAgora();
    super.initState();
  }

  void initAgora() async {
    log("Channel : ${widget.channel}");
    agoraClient = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channel,
        tokenUrl: baseUr,
        username: 'BLa BLa',
      ),
    );
    await agoraClient!.initialize();
    log("Is initialized : ${agoraClient!.isInitialized}");
  }

  void showOrHideButtons() {
    setState(() {
      showButtons = !showButtons;
    });
  }

  void hangUp() async {
    await agoraClient!.engine.leaveChannel();
    await agoraClient!.engine.release();
    QuerySnapshot senderQuerySnapshot = await fireStore
        .collection('users')
        .doc(fireAuth.currentUser!.uid)
        .collection('video_call')
        .get();

    WriteBatch senderBatch = fireStore.batch();

    for (QueryDocumentSnapshot document in senderQuerySnapshot.docs) {
      senderBatch.delete(document.reference);
    }

    await senderBatch.commit();

    //
    QuerySnapshot receiverQuerySnapshot = await fireStore
        .collection('users')
        .doc(widget.receiver_id)
        .collection('video_call')
        .get();

    WriteBatch receiverBatch = fireStore.batch();

    for (QueryDocumentSnapshot document in receiverQuerySnapshot.docs) {
      receiverBatch.delete(document.reference);
    }

    await receiverBatch.commit();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: agoraClient == null
            ? const LoadingWidget()
            : Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: AgoraVideoViewer(
                      client: agoraClient!,
                      layoutType: Layout.oneToOne,
                      enableHostControls: true,
                      showAVState: true,
                    ),
                  ),
                  InkWell(
                    onTap: () => showOrHideButtons(),
                    child: Stack(
                      children: [
                        AnimatedPositioned(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                          bottom: !showButtons ? -500 : 0,
                          left: 0,
                          right: 0,
                          child: AgoraVideoButtons(
                            client: agoraClient!,
                            autoHideButtons: true,
                            autoHideButtonTime: 3,
                            disconnectButtonChild: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: 35,
                              child: IconButton(
                                onPressed: hangUp,
                                icon: const Icon(Icons.call_end),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
