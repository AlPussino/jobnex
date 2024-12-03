import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class VideoCallDismissedWidget extends StatelessWidget {
  final VoidCallback call;
  const VideoCallDismissedWidget({super.key, required this.call});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Iconsax.call_remove_bold,
                    color: AppPallete.red,
                    size: 50,
                  ),
                  Text("Call dismissed"),
                ],
              ),
            ),
            ElevatedButtons(
              buttonName: "Call again",
              onPressed: call,
            ),
          ],
        ),
      ),
    );
  }
}
