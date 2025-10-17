import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class LoginEmailField extends StatelessWidget {
  final TextEditingController controller;
  const LoginEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Email",
      controller: controller,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Enter valid email';
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(v)) return 'Invalid email';
        return null;
      },
    );
  }
}
