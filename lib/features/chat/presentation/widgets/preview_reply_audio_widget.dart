import 'dart:developer';
import 'dart:io';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/features/chat/data/model/chat_reply.dart';
import 'package:JobNex/features/chat/presentation/provider/chat_input_provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PreviewReplyAudioWidget extends StatelessWidget {
  final Map<String, dynamic> receiverData;

  const PreviewReplyAudioWidget({super.key, required this.receiverData});

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
                BuildVoicePreviewReplyWidget(chatReply: chatReply),
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

class BuildVoicePreviewReplyWidget extends StatefulWidget {
  final ChatReply chatReply;

  const BuildVoicePreviewReplyWidget({super.key, required this.chatReply});

  @override
  State<BuildVoicePreviewReplyWidget> createState() =>
      _BuildVoicePreviewReplyWidgetState();
}

class _BuildVoicePreviewReplyWidgetState
    extends State<BuildVoicePreviewReplyWidget> {
  final fireAuth = FirebaseAuth.instance;

  //
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _localFilePath;
  bool _isPlaying = false;
  Duration? _audioDuration;
  Duration _currentPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    _cacheAudioFile(widget.chatReply.message);
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
    final size = MediaQuery.sizeOf(context);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        width: size.width / 2,
        height: size.height / 10,
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: widget.chatReply.message == ""
              ? const LoadingWidget()
              : _localFilePath == null
                  ? const LoadingWidget()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: _playPauseAudio,
                          child: Icon(
                            _isPlaying ? Icons.pause : Icons.play_arrow,
                          ),
                        ),
                        InkWell(
                            onTap: _stopAudio, child: const Icon(Icons.stop)),
                        Text(
                          '${_currentPosition.inSeconds} / ${_audioDuration?.inSeconds ?? 0} sec',
                        ),
                      ],
                    ),
        ),
      ),
    );
  }
}
