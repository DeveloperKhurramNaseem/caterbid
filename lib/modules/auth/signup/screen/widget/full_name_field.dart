import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class FullNameField extends StatelessWidget {
  final TextEditingController controller;
  const FullNameField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Full Name",
      controller: controller,
      validator: (v) => v == null || v.isEmpty ? 'Enter your full name' : null,
      capitalizeFirstLetter: true,
    );
  }
}
