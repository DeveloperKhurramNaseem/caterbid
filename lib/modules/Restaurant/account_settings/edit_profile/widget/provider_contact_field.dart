import 'package:caterbid/core/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class ProviderContactField extends StatelessWidget {
  final TextEditingController controller;

  const ProviderContactField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Phone Number",
      controller: controller,
      keyboardType: TextInputType.phone,
    );
  }
}
