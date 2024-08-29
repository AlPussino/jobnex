import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:freezed_example/core/theme/app_pallete.dart';

class FillInformationPage extends StatefulWidget {
  static const routeName = '/fill-information-page';

  final String name;
  final String email;
  final String mobileNumber;
  final String password;
  final String country;
  final String professionalTitle;
  const FillInformationPage({
    super.key,
    required this.name,
    required this.email,
    required this.mobileNumber,
    required this.password,
    required this.country,
    required this.professionalTitle,
  });

  @override
  State<FillInformationPage> createState() => _FillInformationPageState();
}

class _FillInformationPageState extends State<FillInformationPage> {
  final formKey = GlobalKey<FormState>();
  String gender = "Male";
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Scaffold(
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppPallete.lightBlue),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  focusColor: AppPallete.red,
                  elevation: 1,
                  underline: const SizedBox(),
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  value: gender,
                  borderRadius: BorderRadius.circular(10),
                  items: const [
                    DropdownMenuItem(value: "Male", child: Text("Male")),
                    DropdownMenuItem(value: "Female", child: Text("Female")),
                    DropdownMenuItem(value: "Gay", child: Text("Gay")),
                  ],
                  onChanged: (value) {
                    setState(() {
                      log(value.toString());
                      gender = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: size.height / 30),
            ],
          ),
        ),
      ),
    );
  }
}
