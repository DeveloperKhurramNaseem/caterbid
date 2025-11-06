import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/core/config/app_colors.dart';

class DeleteAccountButton extends StatelessWidget {
  final VoidCallback onPressed;

  const DeleteAccountButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final height = Responsive.responsiveSize(context, 50, 56, 64);
    final fontSize = Responsive.responsiveSize(context, 16, 18, 20);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.c500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'Delete Account',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
