import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import '../config/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;
  final TextEditingController? controller;
  final Widget? suffixIcon; 

  const CustomTextField({
    super.key,
    required this.label,
    this.obscureText = false,
    this.controller,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    double borderRadius = Responsive.responsiveSize(context, 12, 15, 18);
    double fontSize = Responsive.responsiveSize(context, 14, 16, 18);
    double verticalPadding = Responsive.responsiveSize(context, 12, 16, 18);
    double horizontalPadding = Responsive.responsiveSize(context, 12, 16, 20);

    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      style: TextStyle(
        color: AppColors.textDark,
        fontFamily: AppFonts.nunito,
        fontWeight: FontWeight.w600,
        fontSize: fontSize,
      ),
      cursorColor: AppColors.textDark,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: AppColors.textDark,
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),

        suffixIcon: suffixIcon,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: BorderSide(width: 1.5, color: AppColors.c500),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius),
          borderSide: const BorderSide(width: 1.5, color: Colors.redAccent),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: horizontalPadding,
          vertical: verticalPadding,
        ),
      ),
    );
  }
}
