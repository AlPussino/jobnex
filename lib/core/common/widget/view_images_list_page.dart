import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ViewImagesListPage extends StatefulWidget {
  static const routeName = '/view-images-list-page';

  final List<String> images;
  final int id;
  final bool isOwner;
  const ViewImagesListPage({
    super.key,
    required this.images,
    required this.id,
    required this.isOwner,
  });

  @override
  State<ViewImagesListPage> createState() => _ViewImagesListPageState();
}

class _ViewImagesListPageState extends State<ViewImagesListPage> {
  ScrollController? scrollController;
  late PageController pageController;
  bool isButtonsShowed = false;
  late int pageId;
  late List<QueryDocumentSnapshot<Map<String, dynamic>>> imagesList;
  late String downloadUrl;

  @override
  void initState() {
    //

    downloadUrl = widget.images[widget.id];

    pageId = widget.id;
    log("PageID After : $pageId");

    pageController = PageController(initialPage: pageId);
    scrollController = ScrollController(
      onAttach: (position) {
        log("Scroll list attached");
      },
    );
    super.initState();
  }

  @override
  void dispose() {
    scrollController!.dispose();
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context1) {
    final size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onVerticalDragEnd: (details) {
        details.velocity != Velocity.zero ? Navigator.pop(context) : null;
      },
      child: Scaffold(
        backgroundColor: AppPallete.black,
        body: SizedBox(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              GestureDetector(
                onLongPress: () {
                  showModalBottomSheet(
                    enableDrag: true,
                    isDismissible: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    showDragHandle: true,
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: AppPallete.white,
                    elevation: 0,
                    builder: (context) {
                      return SizedBox(
                        height: 100,
                        child: ListTile(
                          leading: const Icon(Iconsax.document_download_bold),
                          title: const Text("Save to phone"),
                          onTap: () async {
                            // requestFileStoragePermissions();
                            // FeedServices.saveNetworkImage(
                            //     downloadUrl, context1);
                            // Navigator.pop(context);
                          },
                        ),
                      );
                    },
                  );
                },
                child: PhotoViewGallery.builder(
                  reverse: widget.isOwner,
                  wantKeepAlive: true,
                  gaplessPlayback: false,
                  pageController: pageController,
                  itemCount: widget.images.length,
                  onPageChanged: (index) {
                    setState(() {
                      pageId = index;
                      downloadUrl = widget.images[index];
                    });
                    double startIndex = scrollController!.position.pixels / 50;
                    double endIndex = (startIndex + size.width / 50);
                    if (index >= startIndex && index <= endIndex) {
                      null;
                    } else {
                      scrollController!.animateTo(
                        index * 50,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  builder: (BuildContext context, int index) {
                    return PhotoViewGalleryPageOptions(
                      onTapDown: (context, details, controllerValue) {
                        setState(() {
                          isButtonsShowed
                              ? isButtonsShowed = false
                              : isButtonsShowed = true;
                        });
                      },
                      imageProvider: CachedNetworkImageProvider(
                          cacheKey: widget.images[index], widget.images[index]),
                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      heroAttributes:
                          PhotoViewHeroAttributes(tag: widget.images[index]),
                    );
                  },
                  loadingBuilder: (context, event) => Center(
                    child: SizedBox(
                      width: 40,
                      height: 40,
                      child: CircularProgressIndicator(
                        color: AppPallete.lightBlue,
                        strokeWidth: 4,
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                event.expectedTotalBytes!,
                      ),
                    ),
                  ),
                ),
              ),
              isButtonsShowed
                  ? SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                            width: size.width,
                            height: size.height / 15,
                            color: AppPallete.transparent,
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundColor: AppPallete.white,
                                  child: BackButton(
                                    color: AppPallete.lightBlue,
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showModalBottomSheet(
                                        enableDrag: true,
                                        isDismissible: true,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        showDragHandle: true,
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: AppPallete.white,
                                        elevation: 0,
                                        builder: (context) {
                                          return SizedBox(
                                            height: 100,
                                            child: ListTile(
                                              leading: const Icon(Iconsax
                                                  .document_download_bold),
                                              title:
                                                  const Text("Save to phone"),
                                              onTap: () async {
                                                // requestFileStoragePermissions();
                                                // FeedServices.saveNetworkImage(
                                                //     downloadUrl, context1);
                                                // Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.more_vert,
                                      color: AppPallete.white,
                                    ))
                              ],
                            )),
                      ),
                    )
                  : const SizedBox(),
              Positioned(
                bottom: 20,
                child: Offstage(
                  offstage: !isButtonsShowed,
                  child: Container(
                    color: AppPallete.transparent,
                    alignment: Alignment.center,
                    height: 50,
                    width: size.width,
                    child: ListView.builder(
                      shrinkWrap: true,
                      reverse: widget.isOwner,
                      addAutomaticKeepAlives: false,
                      addRepaintBoundaries: false,
                      addSemanticIndexes: false,
                      controller: scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: widget.images.length,
                      itemBuilder: (BuildContext context, int index) {
                        final imageUrl = widget.images[index];
                        return InkWell(
                          onTap: () {
                            setState(() {
                              pageController.animateToPage(index,
                                  duration: const Duration(milliseconds: 1),
                                  curve: Curves.linear);
                            });
                          },
                          child: AnimatedSize(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.bounceInOut,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(2),
                                  border: Border.symmetric(
                                      horizontal: BorderSide(
                                        width: 1,
                                        color: pageId == index
                                            ? AppPallete.white
                                            : AppPallete.transparent,
                                      ),
                                      vertical: BorderSide(
                                        width: 2,
                                        color: pageId == index
                                            ? AppPallete.white
                                            : AppPallete.transparent,
                                      ))),
                              height: 50,
                              width: pageId == index ? 50 : 45,
                              child: CachedNetworkImage(
                                alignment: Alignment.center,
                                cacheKey: imageUrl,
                                progressIndicatorBuilder:
                                    (context, url, progress) {
                                  return Center(
                                    child: CircularProgressIndicator(
                                        color: AppPallete.black,
                                        value: progress.downloaded.toDouble()),
                                  );
                                },
                                imageUrl: imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> requestFileStoragePermissions() async {
  //   var status = await Permission.storage.status;
  //   if (status.isDenied) {
  //     status = await Permission.storage.request();
  //   } else if (status.isGranted) {
  //     log("File storage permissions granted.");
  //   } else {
  //     log("File storage permissions denied.");
  //   }
  // }
}
