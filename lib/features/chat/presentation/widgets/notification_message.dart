import 'package:flutter/material.dart';

class NotificationMessage extends StatelessWidget {
  final String message;
  const NotificationMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(child: Chip(label: Text(message)));
  }
}
