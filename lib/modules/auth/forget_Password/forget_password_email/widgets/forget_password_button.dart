import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/main_screen/OTPScreen.dart';

class ForgetPasswordButton extends StatelessWidget {
  final TextEditingController emailController;

  const ForgetPasswordButton({super.key, required this.emailController});

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
            onPressed: () {
              final email = emailController.text;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OTPScreen(email: email),
                ),
              );
            },
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
