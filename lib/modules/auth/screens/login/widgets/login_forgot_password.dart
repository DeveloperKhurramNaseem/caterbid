import 'package:caterbid/modules/auth/screens/forgetPassword/forgetpassword_screen/main_screen/forgetpassword_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:go_router/go_router.dart';

class LoginForgotPassword extends StatelessWidget {
  const LoginForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => context.push(ForgetPasswordScreen.path),
          child: Text(
            "Forgot Password?",
            style: TextStyle(
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w700,
              fontSize: Responsive.responsiveSize(context, 14, 15, 16),
              color: AppColors.textDark,
            ),
          ),
        ),
      ],
    );
  }
}
