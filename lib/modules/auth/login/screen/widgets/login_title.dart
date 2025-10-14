import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class LoginTitle extends StatelessWidget {
  const LoginTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "CaterBid",
        style: TextStyle(
          fontFamily: AppFonts.poppins,
          fontWeight: FontWeight.w700,
          fontSize: Responsive.responsiveSize(context, 28, 32, 36),
          color: AppColors.textDark,
        ),
      ),
    );
  }
}
