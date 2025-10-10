import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class LoginWelcomeText extends StatelessWidget {
  const LoginWelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Welcome back",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveSize(context, 18, 20, 22),
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Sign in to your Account",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
            fontSize: Responsive.responsiveSize(context, 22, 24, 26),
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}
