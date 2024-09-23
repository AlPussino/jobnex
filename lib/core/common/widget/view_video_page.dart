import 'package:flutter/material.dart';
import 'package:JobNex/core/common/widget/video_widget.dart';

class ViewVideoPage extends StatelessWidget {
  static const routeName = '/view-video-page';

  final String videoUrl;
  const ViewVideoPage({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: VideoWidget(videoUrl: videoUrl),
    );
  }
}
