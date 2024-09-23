import 'package:flutter/material.dart';
import 'package:JobNex/features/auth/data/model/user_model.dart';
import 'package:icons_plus/icons_plus.dart';

class Contacts extends StatelessWidget {
  final UserModel snapShotData;
  final Size size;
  const Contacts({super.key, required this.snapShotData, required this.size});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width,
      child: Card(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Iconsax.profile_circle_bold),
              title: const Text("Gender"),
              subtitle: Text(snapShotData.gender),
            ),
            ListTile(
              leading: const Icon(Iconsax.flag_bold),
              title: const Text("Nationality"),
              subtitle: Text(snapShotData.nationality),
            ),
            ListTile(
              leading: const Icon(Iconsax.calendar_2_bold),
              title: const Text("Birth Date"),
              subtitle: Text(snapShotData.birth_date.toString()),
            ),
            ListTile(
              leading: const Icon(Iconsax.message_2_bold),
              title: const Text("Email"),
              subtitle: Text(snapShotData.email),
            ),
            ListTile(
              leading: const Icon(Iconsax.call_bold),
              title: const Text("Mobile Number"),
              subtitle: Text(snapShotData.mobile_number),
            ),
            ListTile(
              leading: const Icon(Iconsax.mobile_bold),
              title: const Text("Address"),
              subtitle: Text(snapShotData.address),
            ),
          ],
        ),
      ),
    );
  }
}
