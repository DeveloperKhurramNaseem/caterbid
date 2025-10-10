import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(label: "Password", obscureText: true);
  }
}
