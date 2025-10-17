import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class LoginPasswordField extends StatelessWidget {
  final TextEditingController controller;
  const LoginPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Password",
      obscureText: true,
      controller: controller,
      validator: (v) => v == null || v.isEmpty ? 'Please enter your password' : null,
    );
  }
}
