import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';

class ReactionIcons {
  static Reaction reaction({
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Reaction(
      value: value,
      icon: Icon(
        icon,
        color: color,
        size: 30,
      ),
    );
  }
}
