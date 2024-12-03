import 'dart:developer';
import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/theme/app_pallete.dart';

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });

    // Set up the video source and caching options
    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
      cacheConfiguration: BetterPlayerCacheConfiguration(
        key: widget.videoUrl,
        useCache: true,
        maxCacheSize: 100 * 1024 * 1024, // 100 MB cache size
        maxCacheFileSize: 10 * 1024 * 1024, // Max 10 MB per file
      ),
      bufferingConfiguration: const BetterPlayerBufferingConfiguration(
        minBufferMs: 20000,
        maxBufferMs: 50000,
        bufferForPlaybackMs: 2500,
        bufferForPlaybackAfterRebufferMs: 5000,
      ),
    );

    // Configure BetterPlayer
    betterPlayerConfiguration = const BetterPlayerConfiguration(
      aspectRatio: 16 / 9,
      fit: BoxFit.contain,
      expandToFill: true,
      allowedScreenSleep: false,
      controlsConfiguration: BetterPlayerControlsConfiguration(
        backgroundColor: AppPallete.black,
        controlBarColor: AppPallete.transparent,
        enablePip: false,
        enableSubtitles: false,
        enableAudioTracks: false,
        enableSkips: true,
        progressBarBackgroundColor: AppPallete.white,
        progressBarBufferedColor: AppPallete.grey,
        progressBarPlayedColor: Color(0xff227143),
        enableMute: true,
        enableFullscreen: true, // Make sure fullscreen is enabled
        iconsColor: AppPallete.white,
        enableRetry: true,
      ),
      autoDetectFullscreenDeviceOrientation: true,
      autoDetectFullscreenAspectRatio: true,
      fullScreenByDefault: false, // Let the user trigger fullscreen
      autoDispose: true,
      autoPlay: false,
      placeholderOnTop: true,
      showPlaceholderUntilPlay: true,
    );

    // Initialize the BetterPlayerController
    betterPlayerController = BetterPlayerController(
      betterPlayerConfiguration,
      betterPlayerDataSource: betterPlayerDataSource,
    );

    // Listen to BetterPlayer events
    betterPlayerController.addEventsListener((BetterPlayerEvent event) {
      log("BetterPlayer Event: ${event.betterPlayerEventType}");

      // Handle specific event types
      if (event.betterPlayerEventType ==
          BetterPlayerEventType.setupDataSource) {
        log("DataSource is setup");

        // Set overridden aspect ratio if available
        double? aspectRatio =
            betterPlayerController.videoPlayerController?.value.aspectRatio;
        if (aspectRatio != null) {
          betterPlayerController.setOverriddenAspectRatio(aspectRatio);
        }
      }

      // Handle fullscreen event (without manually calling enterFullScreen)
      if (event.betterPlayerEventType == BetterPlayerEventType.openFullscreen) {
        log("Entering Fullscreen");
      }

      if (event.betterPlayerEventType == BetterPlayerEventType.hideFullscreen) {
        log("Exiting Fullscreen");
      }
    });

    // Add listener to video player controller for initialization
    betterPlayerController.videoPlayerController?.addListener(() {
      if (betterPlayerController.videoPlayerController?.value.initialized ??
          false) {
        double? aspectRatio =
            betterPlayerController.videoPlayerController?.value.aspectRatio;
        if (aspectRatio != null) {
          betterPlayerController.setOverriddenAspectRatio(aspectRatio);
        }
      }
    });
  }

  @override
  void dispose() {
    betterPlayerController.dispose();
    super.dispose();
  }
  // @override
  // void didChangeDependencies() {
  //   super.didChangeDependencies();
  //   betterPlayerController.pause();
  // }

  // @override
  // void didPushNext() {
  //   super.didPushNext();
  //   betterPlayerController.pause();
  // }

  @override
  Widget build(BuildContext context) {
    // return VisibilityDetector(
    //   key: Key(widget.videoUrl),
    //   onVisibilityChanged: (info) async {
    //     if (info.visibleFraction == 0) {
    //       await betterPlayerController.pause();
    //     } else {
    //       betterPlayerController.setControlsVisibility(true);
    //       if (betterPlayerController.isPlaying()!) {
    //         await betterPlayerController.pause();s
    //       }
    //     }
    //   },
    //   child: ClipRRect(
    //     borderRadius: BorderRadius.circular(10),
    //     child: BetterPlayer(controller: betterPlayerController),
    //   ),
    // );
    return ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: BetterPlayer(controller: betterPlayerController));
  }
}
