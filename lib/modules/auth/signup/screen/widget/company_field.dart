import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class CompanyNameField extends StatelessWidget {
  final TextEditingController controller;
  const CompanyNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Company Name",
      controller: controller,
      validator: (v) =>
          v == null || v.isEmpty ? 'Enter company name' : null,
      capitalizeFirstLetter: true,
    );
  }
}
