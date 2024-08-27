import 'package:flutter/material.dart';

class ErrorWidgets extends StatelessWidget {
  final String errorMessage;
  const ErrorWidgets({super.key, required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(errorMessage),
    );
  }
}
