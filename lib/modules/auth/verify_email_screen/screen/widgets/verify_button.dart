import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class VerifyButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback onPressed;

  const VerifyButton({
    super.key,
    required this.isEnabled,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled
              ? AppColors.c500
              : AppColors.c500.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: Text(
          "Verify",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontSize: Responsive.responsiveSize(context, 15, 16, 17),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
