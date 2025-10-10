import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';

class ChangePasswordButton extends StatelessWidget {
  const ChangePasswordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.c500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () {
          // Change password logic here
        },
        child: const Text(
          "Continue",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
