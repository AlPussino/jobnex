import 'package:JobNex/core/common/widget/video_widget.dart';
import 'package:flutter/material.dart';

class PlayVideoPage extends StatelessWidget {
  static const routeName = '/play-video-page';

  final String videoUrl;
  const PlayVideoPage({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VideoWidget(videoUrl: videoUrl),
    );
  }
}
