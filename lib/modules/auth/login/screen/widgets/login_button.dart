import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onPressed;

  const LoginButton({
    super.key,
    required this.isLoading,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      title: "Login",
      isEnabled: !isLoading,
      onPressed: onPressed,
    );
  }
}
