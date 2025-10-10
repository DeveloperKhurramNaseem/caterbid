import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class ForgetPasswordTitleSection extends StatelessWidget {
  const ForgetPasswordTitleSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Forgot Password",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
            fontSize: Responsive.responsiveSize(context, 21, 23, 25),
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Please enter your email address you used to sign up with Catering Bid",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w500,
            fontSize: Responsive.responsiveSize(context, 16, 17, 18),
            color: AppColors.textDark.withOpacity(0.8),
          ),
        ),
      ],
    );
  }
}
