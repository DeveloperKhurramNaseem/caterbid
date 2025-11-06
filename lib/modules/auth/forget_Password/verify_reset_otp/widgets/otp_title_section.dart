import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class OtpTitleSection extends StatelessWidget {
  final String email;
  const OtpTitleSection({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Verify Code",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
            fontSize: Responsive.responsiveSize(context, 24, 25, 27),
            color: AppColors.textDark,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Please enter the code we just sent to email $email",
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
