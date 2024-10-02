import 'dart:developer';
import 'dart:io';
import 'package:JobNex/core/common/enum/message_type_enum.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:swipe_to/swipe_to.dart';

class VoiceMessage extends StatefulWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;

  const VoiceMessage({
    super.key,
    required this.size,
    required this.chatData,
    required this.chatListData,
  });

  @override
  State<VoiceMessage> createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessage> {
  final fireAuth = FirebaseAuth.instance;
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _localFilePath; // To store the local path of the cached audio file
  bool _isPlaying = false; // Track whether the audio is currently playing
  Duration? _audioDuration; // Store the audio duration
  Duration _currentPosition =
      Duration.zero; // Track the current position of the audio

  @override
  void initState() {
    super.initState();
    _cacheAudioFile(widget.chatData['message'][0]);
  }

  // Method to cache the audio file
  Future<void> _cacheAudioFile(String url) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      String fileName = url.split('/').last;
      _localFilePath = '${directory.path}/$fileName';

      // Check if file exists in the cache
      if (!File(_localFilePath!).existsSync()) {
        // Download the file using Dio if it doesn't exist
        Dio dio = Dio();
        await dio.download(url, _localFilePath!);
      }

      // Get the audio duration once the file is cached
      await _audioPlayer.setSourceDeviceFile(_localFilePath!);
      _audioDuration = await _audioPlayer.getDuration();

      // Set state to update the UI
      setState(() {});

      // Listen to audio position changes
      _audioPlayer.onPositionChanged.listen((Duration p) {
        setState(() {
          _currentPosition = p;
        });
      });
    } catch (e) {
      log('Error downloading or caching the audio file: $e');
    }
  }

  // Play or pause the audio
  void _playPauseAudio() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.play(DeviceFileSource(_localFilePath!));
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  // Stop the audio
  void _stopAudio() async {
    await _audioPlayer.stop();
    setState(() {
      _isPlaying = false;
      _currentPosition = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwipeTo(
      key: UniqueKey(),
      offsetDx: 0.2,
      swipeSensitivity: 8,
      iconColor: AppPallete.lightBlue,
      animationDuration: const Duration(milliseconds: 100),
      onRightSwipe: (details) {
        context.read<ChatInputProvider>().replyMessage(
              ChatReply(
                message: widget.chatData['message'][0],
                message_type: MessageTypeEnum.audio.name,
                message_owner_id: widget.chatData['sender_id'],
              ),
            );
      },
      onLeftSwipe: (details) {
        context.read<ChatInputProvider>().replyMessage(
              ChatReply(
                message: widget.chatData['message'][0],
                message_type: MessageTypeEnum.audio.name,
                message_owner_id: widget.chatData['sender_id'],
              ),
            );
      },
      child: Container(
        width: widget.size.width,
        alignment: widget.chatData['sender_id'] == fireAuth.currentUser!.uid
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: widget.chatData['sender_id'] == fireAuth.currentUser!.uid
              ? Color(widget.chatListData['theme'])
              : null,
          child: Container(
            width: widget.size.width / 2,
            height: widget.size.height / 6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: widget.chatData['message'][0] == ""
                  ? const LoadingWidget()
                  : _localFilePath == null
                      ? const LoadingWidget()
                      : SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Duration: ${_audioDuration?.inSeconds ?? 0} seconds',
                              ),
                              Slider(
                                activeColor: AppPallete.lightBlue,
                                inactiveColor: Theme.of(context).primaryColor,
                                value: _currentPosition.inSeconds.toDouble(),
                                min: 0.0,
                                max:
                                    _audioDuration?.inSeconds.toDouble() ?? 0.0,
                                onChanged: (double value) async {
                                  await _audioPlayer
                                      .seek(Duration(seconds: value.toInt()));
                                },
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: _playPauseAudio,
                                    child: Icon(
                                      _isPlaying
                                          ? Icons.pause
                                          : Icons.play_arrow,
                                    ),
                                  ),
                                  InkWell(
                                      onTap: _stopAudio,
                                      child: const Icon(Icons.stop)),
                                  Text(
                                    '${_currentPosition.inSeconds} / ${_audioDuration?.inSeconds ?? 0} sec',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
