import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/widget/loading.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/profile/presentation/pages/profile_page.dart';

class ChatInformationUserProfileWidget extends StatelessWidget {
  final DocumentReference<Map<String, dynamic>> userData;
  const ChatInformationUserProfileWidget({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: userData.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const LoadingWidget();
        } else if (snapshot.hasError) {
          return Center(child: Text("${snapshot.error}"));
        }
        return Column(
          children: [
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, ProfilePage.routeName,
                        arguments: snapshot.data!['user_id']);
                  },
                  child: CircleAvatar(
                    radius: 40,
                    backgroundColor: AppPallete.backgroundColor,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: CachedNetworkImageProvider(
                          snapshot.data!['profile_url']),
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 12,
                  backgroundColor: AppPallete.backgroundColor,
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
