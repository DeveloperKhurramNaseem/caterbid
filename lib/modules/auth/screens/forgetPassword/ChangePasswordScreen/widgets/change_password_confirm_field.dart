import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class ChangePasswordConfirmField extends StatelessWidget {
  const ChangePasswordConfirmField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(label: "Confirm Password", obscureText: true);
  }
}
