import 'package:caterbid/core/widgets/password_widget/custom_password_field.dart';
import 'package:flutter/material.dart';

class ChangePasswordNewField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String>? onChanged; 

  const ChangePasswordNewField({
    super.key,
    required this.controller,
    this.onChanged, 
  });

  @override
  Widget build(BuildContext context) {
    return CustomPasswordField(
      label: "New Password",
      controller: controller,
      onChanged: onChanged, 
    );
  }
}
