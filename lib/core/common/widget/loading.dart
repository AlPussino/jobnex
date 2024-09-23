import 'package:flutter/material.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingAnimationWidget.discreteCircle(
            color: AppPallete.white,
            secondRingColor: AppPallete.lightBlue,
            size: 30,
          ),
        ],
      ),
    );
  }
}
