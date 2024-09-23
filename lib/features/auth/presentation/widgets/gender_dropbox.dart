import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:JobNex/core/theme/app_pallete.dart';
import 'package:JobNex/features/auth/presentation/provider/sign_up_page_provider.dart';

class GenderDropBox extends StatefulWidget {
  const GenderDropBox({super.key});

  @override
  State<GenderDropBox> createState() => _GenderDropBoxState();
}

class _GenderDropBoxState extends State<GenderDropBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
        value: context.watch<SignUpPageProvider>().currentGender,
        borderRadius: BorderRadius.circular(10),
        items: const [
          DropdownMenuItem(value: "Male", child: Text("Male")),
          DropdownMenuItem(value: "Female", child: Text("Female")),
          DropdownMenuItem(value: "Gay", child: Text("Gay")),
        ],
        onChanged: (value) {
          context.read<SignUpPageProvider>().changeGender(value!);
        },
      ),
    );
  }
}
