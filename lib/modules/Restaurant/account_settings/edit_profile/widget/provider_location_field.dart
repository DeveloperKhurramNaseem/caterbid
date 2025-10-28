import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ProviderLocationField extends StatelessWidget {
  final TextEditingController controller;
  const ProviderLocationField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Business Location",
      controller: controller,
      validator: (v) => v == null || v.isEmpty ? 'Enter your business location' : null,
    );
  }
}
