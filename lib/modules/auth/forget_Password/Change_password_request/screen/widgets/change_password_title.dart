import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class ChangePasswordTitle extends StatelessWidget {
  const ChangePasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Set New Password",
      style: TextStyle(
        fontFamily: AppFonts.nunito,
        fontWeight: FontWeight.w700,
        fontSize: Responsive.responsiveSize(context, 21, 23, 25),
        color: AppColors.textDark,
      ),
    );
  }
}
