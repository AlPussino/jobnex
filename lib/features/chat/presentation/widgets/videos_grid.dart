import 'package:flutter/material.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/features/chat/presentation/provider/media_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:provider/provider.dart';

class VideosGridPage extends StatefulWidget {
  final List<AssetEntity> assetList;

  const VideosGridPage({
    super.key,
    required this.assetList,
  });

  @override
  State<VideosGridPage> createState() => _VideosGridPageState();
}

class _VideosGridPageState extends State<VideosGridPage> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: widget.assetList.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future: widget.assetList[index].thumbnailData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoadingWidget(caption: "Loading...");
            }
            return InkWell(
              onLongPress: () {
                context
                    .read<MediaProvider>()
                    .selectVideo(widget.assetList[index]);
              },
              onTap: () {
                context.read<MediaProvider>().selectedVideos.isEmpty
                    ? null
                    : context
                        .read<MediaProvider>()
                        .selectVideo(widget.assetList[index]);
              },
              child: Padding(
                padding: context
                        .watch<MediaProvider>()
                        .selectedVideos
                        .contains(widget.assetList[index])
                    ? const EdgeInsets.all(8.0)
                    : const EdgeInsets.all(0),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    context
                            .watch<MediaProvider>()
                            .selectedVideos
                            .contains(widget.assetList[index])
                        ? const CircleAvatar(
                            radius: 20,
                            backgroundColor: AppPallete.white,
                            child: Icon(
                              Icons.check,
                              color: AppPallete.elevatedButtonBackgroundColor,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
