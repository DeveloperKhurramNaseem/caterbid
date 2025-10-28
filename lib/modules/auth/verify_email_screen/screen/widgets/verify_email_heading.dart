import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class VerifyEmailHeading extends StatelessWidget {
  const VerifyEmailHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verify Email Address",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
            fontSize: Responsive.responsiveSize(context, 21, 23, 25),
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "We have sent a 6 digit code to your email address",
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
