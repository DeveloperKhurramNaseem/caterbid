import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class ChangePasswordNewField extends StatelessWidget {
  final TextEditingController controller;
  const ChangePasswordNewField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "New Password",
      obscureText: true,
      controller: controller,
    );
  }
}
