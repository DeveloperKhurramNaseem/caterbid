import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class VerifyEmailFooter extends StatelessWidget {
  final int seconds;
  final VoidCallback onResend;

  const VerifyEmailFooter({
    super.key,
    required this.seconds,
    required this.onResend,
  });

  @override
  Widget build(BuildContext context) {
    return seconds > 0
        ? Text(
            "00:${seconds.toString().padLeft(2, '0')}",
            style: TextStyle(
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w700,
              fontSize: Responsive.responsiveSize(context, 16, 17, 18),
              color: AppColors.textDark,
            ),
          )
        : GestureDetector(
            onTap: onResend,
            child: RichText(
              text: TextSpan(
                text: "Didn’t receive 6 digit code? ",
                style: TextStyle(
                  color: AppColors.textDark,
                  fontSize: Responsive.responsiveSize(context, 14, 15, 16),
                ),
                children: [
                  TextSpan(
                    text: "Resend code",
                    style: TextStyle(
                      fontFamily: AppFonts.nunito,
                      color: AppColors.textDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
