import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNavigationBarItems {
  static BottomNavigationBarItem BottomNavigationBarItemWidget({
    required String label,
    required Icon icon,
  }) {
    return BottomNavigationBarItem(icon: icon, label: label);
  }
}
