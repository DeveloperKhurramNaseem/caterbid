import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';

class ForgetPasswordButton extends StatelessWidget {
  final TextEditingController emailController;
  final VoidCallback onPressed; 

  const ForgetPasswordButton({
    super.key,
    required this.emailController,
    required this.onPressed, 
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 220,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.c500,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: onPressed,
            child: const Text(
              "Continue",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
