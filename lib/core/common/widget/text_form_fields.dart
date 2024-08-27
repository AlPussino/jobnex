import 'package:flutter/material.dart';

class TextFormFields extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const TextFormFields({
    super.key,
    required this.hintText,
    required this.controller,
    required this.isObscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      minLines: 1,
      // maxLines: 8,
      obscureText: isObscureText,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$hintText is missing';
        }
        return null;
      },
    );
  }
}
