import 'dart:convert';
import 'dart:io';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/common/widget/video_widget.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/chat/presentation/pages/play_video_page.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class VideoThumbnailImage extends StatefulWidget {
  final String videoUrl;
  final bool isChat;
  const VideoThumbnailImage({
    super.key,
    required this.videoUrl,
    required this.isChat,
  });

  @override
  State<VideoThumbnailImage> createState() => _VideoThumbnailImageState();
}

class _VideoThumbnailImageState extends State<VideoThumbnailImage> {
  String? _thumbnailPath;
  bool isPlaying = false;

  @override
  void initState() {
    super.initState();
    _generateThumbnail();
  }

  String _generateHash(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  Future<void> _generateThumbnail() async {
    String cacheKey = _generateHash(widget.videoUrl);

    final Directory cacheDir = await getTemporaryDirectory();
    String thumbnailPath = '${cacheDir.path}/$cacheKey.png';

    if (File(thumbnailPath).existsSync()) {
      setState(() {
        _thumbnailPath = thumbnailPath;
      });
    } else {
      final String? thumbnail = await VideoThumbnail.thumbnailFile(
        video: widget.videoUrl,
        thumbnailPath: thumbnailPath,
        imageFormat: ImageFormat.PNG,
        maxHeight: 100,
        quality: 50,
      );

      setState(() {
        _thumbnailPath = thumbnail;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isPlaying
        ? ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: VideoWidget(videoUrl: widget.videoUrl))
        : _thumbnailPath != null
            ? Stack(
                alignment: Alignment.center,
                children: [
                  Positioned.fill(
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, PlayVideoPage.routeName,
                            arguments: widget.videoUrl);
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.file(
                          File(_thumbnailPath!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      if (widget.isChat) {
                        setState(() {
                          isPlaying = !isPlaying;
                        });
                      } else {
                        Navigator.pushNamed(context, PlayVideoPage.routeName,
                            arguments: widget.videoUrl);
                      }
                    },
                    icon: const Icon(
                      Icons.play_arrow_rounded,
                      size: 60,
                      color: AppPallete.white,
                    ),
                  ),
                ],
              )
            : const LoadingWidget();
  }
}
