import 'package:animated_icon/animated_icon.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/common/widget/loading.dart';

class AudioMessage extends StatefulWidget {
  final Size size;
  final Map<String, dynamic> chatData;
  final Map<String, dynamic> chatListData;
  const AudioMessage({
    super.key,
    required this.size,
    required this.chatData,
    required this.chatListData,
  });

  @override
  State<AudioMessage> createState() => _AudioMessageState();
}

class _AudioMessageState extends State<AudioMessage> {
  bool isPlaying = false;
  late AudioPlayer audioPlayer;
  Duration audioDuration = Duration.zero;

  final fireAuth = FirebaseAuth.instance;

  @override
  void initState() {
    audioPlayer = AudioPlayer();

    getAudioDuration();

    //Listen for player event
    audioPlayer.onPlayerComplete.listen(
      (event) {
        setState(() {
          isPlaying = false;
        });
      },
    );

    // Listen for the duration change event
    audioPlayer.onDurationChanged.listen((duration) {
      setState(() {
        audioDuration = duration;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> getAudioDuration() async {
    // Load the audio source to get the duration

    await audioPlayer.setSourceUrl(widget.chatData['message'][0]);
    final duration = await audioPlayer.getDuration();
    if (duration != null) {
      setState(() {
        audioDuration = duration;
      });
    }
  }

  void playAudio() async {
    setState(() {
      isPlaying = true;
    });
    await audioPlayer.play(UrlSource(widget.chatData['message'][0]));
  }

  void pauseAudio() async {
    setState(() {
      isPlaying = false;
    });
    await audioPlayer.pause();
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
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
          width: widget.size.width / 2,
          height: widget.size.height / 10,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: widget.chatData['message'][0] == ""
                ? const LoadingWidget(caption: "")
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: isPlaying ? pauseAudio : playAudio,
                        icon: Icon(
                          isPlaying ? Icons.pause_circle : Icons.play_circle,
                          // color: Colors.white,
                        ),
                      ),

                      //
                      isPlaying
                          ? AnimateIcon(
                              key: UniqueKey(),
                              onTap: isPlaying ? pauseAudio : playAudio,
                              iconType: IconType.continueAnimation,
                              // color: Colors.white,
                              animateIcon: AnimateIcons.loading3,
                            )
                          : audioDuration == Duration.zero
                              ? AnimateIcon(
                                  key: UniqueKey(),
                                  onTap: isPlaying ? pauseAudio : playAudio,
                                  iconType: IconType.continueAnimation,
                                  // color: Colors.white,
                                  animateIcon: AnimateIcons.loading6,
                                  height: 30,
                                )
                              : Text(
                                  formatDuration(audioDuration),
                                ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
