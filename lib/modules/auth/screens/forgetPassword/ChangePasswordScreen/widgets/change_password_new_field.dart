import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_textfield.dart';

class ChangePasswordNewField extends StatelessWidget {
  const ChangePasswordNewField({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomTextField(label: "New Password", obscureText: true);
  }
}
