import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';
import 'package:freezed_example/features/profile/presentation/pages/profile_page.dart';

class UserCard extends StatelessWidget {
  final Map<String, dynamic> userData;
  const UserCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProfilePage.routeName,
            arguments: userData['user_id']);
      },
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: AppPallete.lightBlue),
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage:
                    CachedNetworkImageProvider(userData['profile_url']),
              ),
              SizedBox(width: size.width / 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    userData['name'],
                  ),
                  Text(
                    userData['email'],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
