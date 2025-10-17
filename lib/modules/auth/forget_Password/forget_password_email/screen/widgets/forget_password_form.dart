import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class ForgetPasswordForm extends StatelessWidget {
  final TextEditingController emailController;

  const ForgetPasswordForm({super.key, required this.emailController});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      label: "Email",
      controller: emailController,
      validator: (v) {
        if (v == null || v.isEmpty) return 'Enter valid email';
        final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
        if (!emailRegex.hasMatch(v)) return 'Invalid email';
        return null;
      },
    );
  }
}
