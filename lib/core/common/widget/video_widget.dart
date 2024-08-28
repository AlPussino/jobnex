import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoWidget extends StatefulWidget {
  final String videoUrl;
  const VideoWidget({super.key, required this.videoUrl});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget>
    with SingleTickerProviderStateMixin, RouteAware {
  late BetterPlayerController betterPlayerController;
  late BetterPlayerDataSource betterPlayerDataSource;
  late BetterPlayerConfiguration betterPlayerConfiguration;
  final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) async {
        routeObserver.subscribe(this, ModalRoute.of(context)!);
      },
    );

    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        key: widget.videoUrl,
        useCache: true,
        maxCacheSize: 100 * 1024 * 1024,
        maxCacheFileSize: 10 * 1024 * 1024,
      ),
      bufferingConfiguration: const BetterPlayerBufferingConfiguration(
        minBufferMs: 20000,
        maxBufferMs: 50000,
        bufferForPlaybackMs: 2500,
        bufferForPlaybackAfterRebufferMs: 5000,
      ),
    );

    //
    betterPlayerConfiguration = BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      allowedScreenSleep: false,
      fit: BoxFit.contain,
      expandToFill: true,
      controlsConfiguration: const BetterPlayerControlsConfiguration(
        backgroundColor: Colors.black,
        controlBarColor: Colors.transparent,
        enablePip: false,
        enableSubtitles: false,
        enableAudioTracks: false,
        enableSkips: true,
        progressBarBackgroundColor: Colors.white,
        progressBarBufferedColor: Colors.grey,
        progressBarPlayedColor: Color(0xff227143),
        enableMute: true,
        enableFullscreen: true,
        iconsColor: Colors.white,
        enableRetry: true,
      ),
      autoDetectFullscreenDeviceOrientation: false,
      autoDetectFullscreenAspectRatio: false,
      fullScreenByDefault: false,
      overlay: Container(
        color: Colors.black.withOpacity(0.10),
      ),
      placeholderOnTop: true,
      showPlaceholderUntilPlay: true,
      autoDispose: true,
      autoPlay: false,
      subtitlesConfiguration:
          const BetterPlayerSubtitlesConfiguration(fontSize: 10),
    );

    betterPlayerController = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: betterPlayerDataSource,
    );

    betterPlayerController.addEventsListener((BetterPlayerEvent event) {
      if (event.betterPlayerEventType ==
          BetterPlayerEventType.setupDataSource) {
        double? aspectRatio =
            betterPlayerController.videoPlayerController?.value.aspectRatio;
        if (aspectRatio != null) {
          betterPlayerController.setOverriddenAspectRatio(aspectRatio);
        }
      } else if (event.betterPlayerEventType ==
          BetterPlayerEventType.openFullscreen) {
        setState(() {
          betterPlayerController.enterFullScreen();
        });
      }
    });
  }

  @override
  void dispose() async {
    betterPlayerController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    await betterPlayerController.pause();
    super.didChangeDependencies();
  }

  @override
  void didPushNext() async {
    super.didPushNext();
    await betterPlayerController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (info) async {
        if (info.visibleFraction == 0) {
          await betterPlayerController.pause();
        } else {
          betterPlayerController.setControlsVisibility(true);
          betterPlayerController.isPlaying()!
              ? await betterPlayerController.pause()
              : null;
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BetterPlayer(controller: betterPlayerController),
      ),
    );
  }
}
