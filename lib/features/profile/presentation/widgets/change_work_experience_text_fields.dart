import 'package:flutter/material.dart';

class ChangeWorkExperienceTextFields extends StatefulWidget {
  final TextEditingController controller;
  final String title;
  final VoidCallback onPressed;
  final bool readOnly;
  const ChangeWorkExperienceTextFields({
    super.key,
    required this.controller,
    required this.title,
    required this.onPressed,
    required this.readOnly,
  });

  @override
  State<ChangeWorkExperienceTextFields> createState() =>
      _ChangeWorkExperienceTextFields();
}

class _ChangeWorkExperienceTextFields
    extends State<ChangeWorkExperienceTextFields> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: TextField(
        readOnly: widget.readOnly,
        maxLines: 6,
        minLines: 1,
        controller: widget.controller,
        decoration: InputDecoration(
          hintText: widget.title,
          suffixIcon: widget.controller.text.isNotEmpty
              ? IconButton(
                  onPressed: widget.onPressed,
                  icon: const Icon(Icons.check, color: Colors.green),
                )
              : null,
        ),
        onChanged: (value) {
          setState(() {
            widget.controller.text = value;
          });
        },
      ),
    );
  }
}
