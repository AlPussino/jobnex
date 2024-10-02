import 'package:JobNex/core/common/widget/loading.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class CachedNetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  const CachedNetworkImageWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      key: Key(imageUrl),
      cacheKey: imageUrl,
      imageUrl: imageUrl,
      memCacheHeight: 200,
      memCacheWidth: 200,
      maxHeightDiskCache: 200,
      maxWidthDiskCache: 200,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => const LoadingWidget(),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
