import 'package:caterbid/core/widgets/password_widget/custom_password_field.dart';
import 'package:flutter/material.dart';

class PasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const PasswordField({
    super.key,
    required this.controller,
    required this.label,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPasswordField(
      label: label,
      controller: controller,
      validator: validator,
    );
  }
}
