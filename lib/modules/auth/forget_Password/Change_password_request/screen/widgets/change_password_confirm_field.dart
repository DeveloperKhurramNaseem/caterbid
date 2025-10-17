import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class ChangePasswordConfirmField extends StatelessWidget {
  final TextEditingController controller;
  const ChangePasswordConfirmField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Confirm Password",
      obscureText: true,
      controller: controller,
    );
  }
}
