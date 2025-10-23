import 'package:caterbid/core/widgets/password_widget/custom_password_field.dart';
import 'package:flutter/material.dart';

class OldPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const OldPasswordField({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPasswordField(
      label: "Old Password",
      controller: controller,
      onChanged: onChanged,
    );
  }
}
