import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:animated_icon/animated_icon.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:freezed_example/core/common/enum/message_type_enum.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:freezed_example/features/chat/presentation/pages/select_photos_page.dart';
import 'package:freezed_example/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:freezed_example/features/chat/presentation/widgets/add_more_pop_up_menu_icon_button.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class ChatInputs extends StatefulWidget {
  final Map<String, dynamic> receiverData;
  final Map<String, dynamic> chatListData;
  final TextEditingController messageController;

  const ChatInputs({
    super.key,
    required this.receiverData,
    required this.messageController,
    required this.chatListData,
  });

  @override
  State<ChatInputs> createState() => _ChatInputsState();
}

class _ChatInputsState extends State<ChatInputs> {
  bool showEmoji = false;
  bool isRecording = false;
  FlutterSoundRecorder? flutterSoundRecorder;
  bool isRecorderInit = false;
  String? audioPath;
  int durationInSeconds = 0;
  Timer? timer;

  void startTimer() {
    timer?.cancel();

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        durationInSeconds++;
      });
    });
  }

  void stopTimer() {
    timer?.cancel();
  }

  String formatDuration(int totalSeconds) {
    int minutes = totalSeconds ~/ 60;
    int seconds = totalSeconds % 60;
    String secondsStr = seconds.toString().padLeft(2, '0');
    return '$minutes:$secondsStr';
  }

  void openAudio() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Mic is not allowed');
    }
    await flutterSoundRecorder!.openRecorder();
    isRecorderInit = true;
  }

  void startAudioRecording() async {
    startTimer();
    var tempDirectory = await getTemporaryDirectory();
    audioPath = "${tempDirectory.path}/flutter_sound.aac";
    if (!isRecorderInit) {
      return;
    }
    await flutterSoundRecorder!.startRecorder(toFile: audioPath);
  }

  void sendAudioMessage() {
    context.read<ChatBloc>().add(ChatSendFileMessage(
          widget.receiverData['user_id'],
          [File(audioPath!)],
          MessageTypeEnum.audio,
        ));
    audioPath = null;
  }

  void stopAudioRecording() async {
    stopTimer();
    await flutterSoundRecorder!.stopRecorder();
    audioPath = null;
  }

  void sendTextMessage() async {
    if (widget.messageController.text.isEmpty) {
      context.read<ChatBloc>().add(ChatSendTextMessage(
          widget.receiverData['user_id'],
          widget.chatListData['quick_react'],
          MessageTypeEnum.emoji));
    } else {
      context.read<ChatBloc>().add(ChatSendTextMessage(
          widget.receiverData['user_id'],
          widget.messageController.text,
          MessageTypeEnum.text));
      widget.messageController.clear();
    }
  }

  void sendImageMessage() async {
    List<XFile>? pickedXFiles = await ImagePicker().pickMultiImage();

    if (pickedXFiles.isNotEmpty) {
      List<File> fileList = [];
      for (XFile pickedXFile in pickedXFiles) {
        File imageFile = File(pickedXFile.path);
        fileList.add(imageFile);
      }
      context.read<ChatBloc>().add(ChatSendFileMessage(
            widget.receiverData['user_id'],
            fileList,
            MessageTypeEnum.image,
          ));
    }
  }

  void sendCameraMessage() async {
    XFile? pickedXFile =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedXFile != null) {
      File imageFile = File(pickedXFile.path);

      context.read<ChatBloc>().add(ChatSendFileMessage(
            widget.receiverData['user_id'],
            [imageFile],
            MessageTypeEnum.image,
          ));
    }
  }

  void sendImagesMessage() async {
    var status = await Permission.photos.request();

    if (status.isGranted) {
      log("Permission granted");
      final PermissionState ps = await PhotoManager.requestPermissionExtend();
      PhotoManager.setIgnorePermissionCheck(true);

      log(ps.toString());
      log(ps.isAuth.toString());
      if (ps.isAuth) {
        Navigator.pushNamed(context, SelectPhotosPage.routeName,
            arguments: widget.receiverData);
      } else if (ps.hasAccess) {
      } else {}
    } else if (status.isDenied) {
      var st = await Permission.storage.request();
      if (st.isGranted) {
        Navigator.pushNamed(context, SelectPhotosPage.routeName,
            arguments: widget.receiverData);
      }
    } else if (status.isPermanentlyDenied) {
      log("Permission permanently denied");

      openAppSettings();
    }
  }

  @override
  void initState() {
    flutterSoundRecorder = FlutterSoundRecorder();
    openAudio();
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return ChangeNotifierProvider(
      create: (context) => ChatInputProvider(),
      lazy: true,
      builder: (context, child) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (context.watch<ChatInputProvider>().inputTexts.isEmpty)
                    Row(
                      children: [
                        Draggable(
                          data: "mic",
                          feedback: const CircleAvatar(
                              child: Icon(Iconsax.microphone_2_bold)),
                          onDragStarted: () {
                            startAudioRecording();
                            setState(() {
                              isRecording = true;
                            });
                          },
                          onDragEnd: (details) {
                            if (isRecording) {
                              log('Voice message sent!');
                              sendAudioMessage();
                              setState(() {
                                stopAudioRecording();
                                isRecording = false;
                              });
                            }
                          },
                          childWhenDragging: Card(
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  AnimateIcon(
                                    key: UniqueKey(),
                                    onTap: () {},
                                    iconType: IconType.continueAnimation,
                                    color: Theme.of(context).primaryColor,
                                    animateIcon: AnimateIcons.loading3,
                                  ),
                                  SizedBox(width: size.width / 20),
                                  Text(formatDuration(durationInSeconds)),
                                  SizedBox(width: size.width / 20),
                                  if (isRecording)
                                    DragTarget(
                                      builder: (context, candidateData,
                                          rejectedData) {
                                        return CircleAvatar(
                                          radius:
                                              candidateData.isEmpty ? 20 : 30,
                                          backgroundColor: AppPallete.red,
                                          child: const Icon(
                                            Icons.delete,
                                            size: 20,
                                          ),
                                        );
                                      },
                                      onAcceptWithDetails: (data) {
                                        setState(() {
                                          stopAudioRecording();
                                          isRecording = false;
                                        });
                                        log('Recording canceled');
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ),
                          child: const CircleAvatar(
                              child: Icon(Iconsax.microphone_2_bold)),
                        ),

                        //
                        if (!isRecording)
                          AddMorePopUpMenuIconButton(
                              receiverData: widget.receiverData),

                        if (!isRecording)
                          IconButton(
                            onPressed: sendCameraMessage,
                            icon: const Icon(Iconsax.camera_bold),
                          ),
                        if (!isRecording)
                          IconButton(
                            onPressed: sendImagesMessage,
                            // onPressed: sendFileMessage,
                            icon: const Icon(Iconsax.gallery_bold),
                          ),
                      ],
                    ),

                  if (!isRecording)
                    Expanded(
                      child: TextField(
                        autofocus: false,
                        controller: widget.messageController,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(8),
                          suffixIcon: IconButton(
                            onPressed: () async {
                              FocusManager.instance.primaryFocus!.unfocus();
                              await Future.delayed(
                                      const Duration(milliseconds: 50))
                                  .then(
                                (value) {
                                  setState(() {
                                    showEmoji = !showEmoji;
                                  });
                                },
                              );
                            },
                            icon: const Icon(Iconsax.emoji_happy_bold),
                          ),
                        ),
                        minLines: 1,
                        maxLines: 4,
                        onTap: () {
                          setState(() {
                            showEmoji = false;
                          });
                        },
                        onChanged: (value) {
                          context.read<ChatInputProvider>().userTypes(value);
                        },
                      ),
                    ),
                  if (!isRecording)
                    IconButton(
                      onPressed: () {
                        sendTextMessage();
                        context.read<ChatInputProvider>().sentText();
                      },
                      icon:
                          context.watch<ChatInputProvider>().inputTexts.isEmpty
                              ? Text(widget.chatListData['quick_react'],
                                  style: const TextStyle(fontSize: 25))
                              : const Icon(Iconsax.send_2_bulk),
                    ),

                  /////

                  // if (context.watch<ChatInputProvider>().inputTexts.isEmpty)
                  //   TextButton(
                  //     onPressed: sendTextMessage,
                  //     child: Text(widget.chatListData['quick_react'],
                  //         style: const TextStyle(fontSize: 25)),
                  //   )
                ],
              ),

              //
              if (showEmoji)
                AnimatedContainer(
                  duration: const Duration(seconds: 3),
                  alignment: Alignment.bottomCenter,
                  curve: Curves.bounceInOut,
                  child: EmojiPicker(
                    onEmojiSelected: (category, emoji) {},
                    onBackspacePressed: () {},
                    textEditingController: widget.messageController,
                    config: Config(
                      checkPlatformCompatibility: true,
                      emojiViewConfig: EmojiViewConfig(
                        horizontalSpacing: 10,
                        verticalSpacing: 10,
                        emojiSizeMax: 25,
                        gridPadding: EdgeInsets.zero,
                        backgroundColor: Theme.of(context).canvasColor,
                        columns: 7,
                        buttonMode: ButtonMode.CUPERTINO,
                      ),
                      swapCategoryAndBottomBar: false,
                      bottomActionBarConfig: const BottomActionBarConfig(
                        enabled: false,
                      ),
                      categoryViewConfig: CategoryViewConfig(
                        categoryIcons: const CategoryIcons(),
                        recentTabBehavior: RecentTabBehavior.NONE,
                        tabIndicatorAnimDuration: kTabScrollDuration,
                        backgroundColor: Theme.of(context).canvasColor,
                        iconColorSelected: AppPallete.lightBlue,
                        indicatorColor: AppPallete.lightBlue,
                        showBackspaceButton: true,
                        backspaceColor: AppPallete.lightBlue,
                        dividerColor: AppPallete.grey,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
