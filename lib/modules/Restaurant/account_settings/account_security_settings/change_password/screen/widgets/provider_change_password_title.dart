import 'package:caterbid/core/config/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class ProviderChangePasswordTitle extends StatelessWidget {
  const ProviderChangePasswordTitle({super.key});

  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = Responsive.responsiveSize(context, 18, 20, 22);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Change Password",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
            fontSize: fontSizeTitle,
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Use at least 8 characters including letters and numbers",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w400,
            color: AppColors.textDark,
            fontSize: Responsive.responsiveSize(context, 16, 17, 18),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
