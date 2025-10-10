import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:go_router/go_router.dart';

class LoginSignupText extends StatelessWidget {
  const LoginSignupText({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/'),
      child: Center(
        child: RichText(
          text: const TextSpan(
            text: "Do you have an account? ",
            style: TextStyle(color: AppColors.textDark, fontSize: 14),
            children: [
              TextSpan(
                text: "Sign Up",
                style: TextStyle(
                  fontFamily: AppFonts.nunito,
                  color: AppColors.textDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
