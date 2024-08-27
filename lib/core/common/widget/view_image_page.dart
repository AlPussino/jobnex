import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:photo_view/photo_view.dart';

class ViewImagePage extends StatefulWidget {
  static const routeName = '/view-image-page';

  final String image;
  const ViewImagePage({super.key, required this.image});

  @override
  State<ViewImagePage> createState() => _ViewImagePageState();
}

class _ViewImagePageState extends State<ViewImagePage> {
  double top = 0.0;
  double scale = 1.0;
  bool isDragging = false;

  final double popThreshold = 100;

  void onVerticalDragUpdate(DragUpdateDetails details) {
    setState(() {
      top += details.delta.dy;
      scale = 0.9;
      isDragging = true;
    });
  }

  void onVerticalDragEnd(DragEndDetails details) {
    if (top > popThreshold) {
      Navigator.pop(context);
    }
    setState(() {
      top = 0.0;
      scale = 1.0;
      isDragging = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onVerticalDragUpdate: onVerticalDragUpdate,
          onVerticalDragEnd: onVerticalDragEnd,
          child: AnimatedContainer(
            alignment: Alignment.center,
            duration: const Duration(milliseconds: 500),
            child: Transform.translate(
              offset: Offset(0, top),
              child: Transform.scale(
                scale: scale,
                child: PhotoView(
                  backgroundDecoration:
                      const BoxDecoration(color: AppPallete.transpartent),
                  heroAttributes: PhotoViewHeroAttributes(tag: widget.image),
                  onScaleEnd: (context, details, controllerValue) {
                    controllerValue.position == const Offset(0.0, 0.0)
                        ? Navigator.pop(context)
                        : null;
                  },
                  wantKeepAlive: true,
                  gaplessPlayback: true,
                  disableGestures: false,
                  enablePanAlways: false,
                  initialScale: PhotoViewComputedScale.contained,
                  minScale: PhotoViewComputedScale.contained,
                  maxScale: PhotoViewComputedScale.covered,
                  imageProvider: CachedNetworkImageProvider(
                    widget.image,
                    cacheKey: widget.image,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
