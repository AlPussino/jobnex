import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/config/agora_config.dart';
import 'package:agora_uikit/agora_uikit.dart';
import 'package:flutter/material.dart';

const String appId = "cef99149d5bc4c03ae29ead08c679853";

class VideoCallPage extends StatefulWidget {
  final String channelId;
  const VideoCallPage({super.key, required this.channelId});

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  AgoraClient? agoraClient;
  String baseUr = "https://whatsapp-clone-akk-0784166b3ed4.herokuapp.com";
  bool showButtons = true;

  @override
  void initState() {
    agoraClient = AgoraClient(
      agoraConnectionData: AgoraConnectionData(
        appId: AgoraConfig.appId,
        channelName: widget.channelId,
        tokenUrl: baseUr,
      ),
    );

    initAgora();
    super.initState();
  }

  void initAgora() async {
    await agoraClient!.initialize();
  }

  void showOrHideButtons() {
    setState(() {
      showButtons = !showButtons;
    });
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
                    borderRadius: BorderRadius.circular(18),
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
                                onPressed: () async {
                                  await agoraClient!.engine.leaveChannel();
                                  // ref.read(callControllerProvider).endCall(
                                  //     context,
                                  //     widget.call.callerId,
                                  //     widget.call.receiverId);
                                  Navigator.pop(context);
                                },
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
