import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class ChangePasswordDescription extends StatelessWidget {
  final String email;
  const ChangePasswordDescription({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        "Use at least 8 characters including letters and numbers $email",
        style: TextStyle(
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeight.w500,
          fontSize: Responsive.responsiveSize(context, 16, 17, 18),
          color: AppColors.textDark.withOpacity(0.8),
        ),
      ),
    );
  }
}
