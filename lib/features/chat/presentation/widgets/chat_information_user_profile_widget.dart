import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/common/widget/loading.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';

class ChatInformationUserProfileWidget extends StatelessWidget {
  final DocumentReference<Map<String, dynamic>> userData;
  const ChatInformationUserProfileWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userData.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget(caption: "");
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppPallete.scaffoldBackgroundColor,
                  child: CircleAvatar(
                    radius: 38,
                    backgroundImage: CachedNetworkImageProvider(
                        snapshot.data!['profile_url']),
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppPallete.scaffoldBackgroundColor,
                  child: CircleAvatar(
                      radius: 8,
                      backgroundColor: snapshot.data!['is_online']
                          ? AppPallete.green
                          : AppPallete.grey),
                )
              ],
            ),
            Text(snapshot.data!['name']),
          ],
        );
      },
    );
  }
}
