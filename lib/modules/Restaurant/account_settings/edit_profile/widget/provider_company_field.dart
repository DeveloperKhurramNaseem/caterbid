import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ProviderCompanyField extends StatelessWidget {
  final TextEditingController controller;
  const ProviderCompanyField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Business Name",
      controller: controller,
      validator: (v) => v == null || v.isEmpty ? 'Enter company name' : null,
      capitalizeFirstLetter: true,
    );
  }
}
