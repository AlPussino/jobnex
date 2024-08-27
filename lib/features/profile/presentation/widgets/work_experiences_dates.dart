import 'dart:developer';
import 'package:flutter/material.dart';

class WorkExperienceDates extends StatelessWidget {
  final TextEditingController dateController;
  final String hintText;
  const WorkExperienceDates(
      {super.key, required this.dateController, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: dateController,
      readOnly: true,
      decoration: InputDecoration(
        hintText: hintText,
      ),
      onTap: () async {
        DateTime? dateTime = await showDatePicker(
          context: context,
          firstDate: DateTime(1990),
          lastDate: DateTime.now(),
        );
        dateController.text = dateTime.toString();
        dateTime == null ? dateController.clear() : null;
        log(dateController.text);
      },
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}
