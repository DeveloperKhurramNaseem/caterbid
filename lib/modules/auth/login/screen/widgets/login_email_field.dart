import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class LoginEmailField extends StatelessWidget {
  final TextEditingController controller;
  const LoginEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(label: "Email", controller: controller);
  }
}
