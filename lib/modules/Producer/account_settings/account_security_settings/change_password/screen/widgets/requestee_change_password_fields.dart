import 'package:caterbid/core/widgets/password_widget/custom_password_field.dart';

import 'package:flutter/material.dart';


class RequesteeChangePasswordFields extends StatelessWidget {
  final TextEditingController oldPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final void Function(String, String) onPasswordChanged;

  const RequesteeChangePasswordFields({
    super.key,
    required this.oldPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onPasswordChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPasswordField(
          label: "Old Password",
          controller: oldPasswordController,
        ),
        const SizedBox(height: 16),
        CustomPasswordField(
          label: "New Password",
          controller: newPasswordController,
          onChanged: (value) =>
              onPasswordChanged(value, confirmPasswordController.text),
        ),
        const SizedBox(height: 16),
        CustomPasswordField(
          label: "Confirm Password",
          controller: confirmPasswordController,
          onChanged: (value) =>
              onPasswordChanged(newPasswordController.text, value),
          validator: (value) {
            if (value != newPasswordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
