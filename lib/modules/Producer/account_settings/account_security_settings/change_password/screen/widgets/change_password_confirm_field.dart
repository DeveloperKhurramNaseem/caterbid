import 'package:caterbid/core/widgets/password_widget/custom_password_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordConfirmField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const ChangePasswordConfirmField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPasswordField(
      label: "Confirm Password",
      controller: controller,
      onChanged: onChanged,
    );
  }
}
