import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class LoginEmailField extends StatelessWidget {
  const LoginEmailField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(label: "Email");
  }
}
