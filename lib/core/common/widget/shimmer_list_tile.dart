import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    //
    return Shimmer.fromColors(
      baseColor: Theme.of(context).shadowColor,
      highlightColor: Theme.of(context).highlightColor,
      enabled: true,
      child: Container(
        padding: const EdgeInsets.all(0),
        margin: const EdgeInsets.all(10),
        width: size.width,
        height: size.height / 15,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppPallete.lightBlue,
              radius: size.height / 30,
            ),
            SizedBox(width: size.width / 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: size.height / 60,
                  width: size.width / 2.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Theme.of(context).canvasColor,
                  ),
                ),
                Container(
                  height: size.height / 35,
                  width: size.width / 1.4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: Theme.of(context).canvasColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
