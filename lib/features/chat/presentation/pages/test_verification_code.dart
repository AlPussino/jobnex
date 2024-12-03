import 'dart:developer';
import 'package:JobNex/features/auth/presentation/widgets/elevated_buttons.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class TestVerificationCodePage extends StatefulWidget {
  const TestVerificationCodePage({super.key});

  @override
  State<TestVerificationCodePage> createState() =>
      _TestVerificationCodePageState();
}

class _TestVerificationCodePageState extends State<TestVerificationCodePage> {
  final formKey = GlobalKey<FormState>();
  final controller = TextEditingController();
  final focusNode = FocusNode();

  @override
  void dispose() {
    controller.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: Colors.green),
    );

    final cursor = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 1,
          decoration: const BoxDecoration(
            color: Colors.black,
          ),
        ),
      ],
    );
    final preFilledWidget = Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          width: 56,
          height: 1,
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ],
    );
    const submittedPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: Colors.green),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey)),
      ),
    );
    const focusPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: Colors.green),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black)),
      ),
    );
    const errorPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(fontSize: 22, color: Colors.red),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.red)),
      ),
    );
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("FILLL"),
                Pinput(
                  length: 6,
                  autofocus: true,
                  pinAnimationType: PinAnimationType.slide,
                  controller: controller,
                  focusNode: focusNode,
                  defaultPinTheme: defaultPinTheme,
                  showCursor: true,
                  cursor: cursor,
                  preFilledWidget: preFilledWidget,
                  submittedPinTheme: submittedPinTheme,
                  errorPinTheme: errorPinTheme,
                  focusedPinTheme: focusPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  validator: (value) {
                    if (value!.length != 6) {
                      return "Enter valid verification code";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButtons(
                  buttonName: 'Submit',
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      log(controller.text);
                    } else {
                      focusNode.unfocus();
                      log("not validated");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
