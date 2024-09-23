import 'package:flutter/material.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:icons_plus/icons_plus.dart';

class Reaction {
  static final Map<String, Icon> reactionIcons = {
    "like": const Icon(AntDesign.like_fill, color: AppPallete.lightBlue),
    "dislike": const Icon(AntDesign.dislike_fill, color: AppPallete.lightBlue),
    "love": const Icon(AntDesign.heart_fill, color: AppPallete.pink),
    "happy": const Icon(AntDesign.smile_fill, color: AppPallete.yellow),
    "sad": const Icon(AntDesign.frown_fill, color: AppPallete.yellow),
  };
}
