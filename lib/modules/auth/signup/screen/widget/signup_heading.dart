import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class SignUpHeading extends StatelessWidget {
  const SignUpHeading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's start",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w400,
            fontSize: Responsive.responsiveSize(context, 18, 20, 22),
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          "Create an Account",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
            fontSize: Responsive.responsiveSize(context, 23, 25, 27),
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }
}
