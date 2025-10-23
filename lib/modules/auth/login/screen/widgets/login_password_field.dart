import 'package:caterbid/core/widgets/password_widget/custom_password_field.dart';
import 'package:flutter/material.dart';

class LoginPasswordField extends StatelessWidget {
  final TextEditingController controller;
  const LoginPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomPasswordField(
      label: "Password",
      controller: controller,
      validator: (v) => v == null || v.isEmpty ? 'Please enter your password' : null,
    );
  }
}


