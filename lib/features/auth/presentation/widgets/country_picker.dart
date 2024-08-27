import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:icons_plus/icons_plus.dart';

class CountryPicker extends StatelessWidget {
  final TextEditingController nationalityController;
  const CountryPicker({super.key, required this.nationalityController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: nationalityController,
      readOnly: true,
      onTap: () {
        showCountryPicker(
          context: context,
          showPhoneCode: false,
          onSelect: (value) {
            nationalityController.text = value.name;
          },
        );
      },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Iconsax.map_bold),
        hintText: nationalityController.text.isEmpty
            ? "Country"
            : nationalityController.text,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return 'Country is missing';
        }
        return null;
      },
    );
  }
}
