import 'package:flutter/material.dart';
import '../config/app_colors.dart';
import '../config/app_constants.dart';
import '../utils/responsive.dart';

class AppLogo extends StatelessWidget {
  final double? fontSize;
  final Color? color;

  const AppLogo({super.key, this.fontSize, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      "CaterBid",
      style: TextStyle(
        fontFamily: AppFonts.poppins,
        fontWeight: FontWeight.w700,
        fontSize: fontSize ?? Responsive.responsiveSize(context, 28, 32, 36),
        color: color ?? AppColors.textDark,
      ),
    );
  }
}
