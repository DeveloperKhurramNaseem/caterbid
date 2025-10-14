import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';

class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go(LoginScreen.path),
      child: Center(
        child: RichText(
          text: const TextSpan(
            text: "Do you have an account? ",
            style: TextStyle(color: AppColors.textDark, fontSize: 14),
            children: [
              TextSpan(
                text: "Sign In",
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
