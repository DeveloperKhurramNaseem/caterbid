import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class ChangeButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ChangeButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    double height = Responsive.responsiveSize(context, 48, 52, 56);
    double fontSize = Responsive.responsiveSize(context, 16, 18, 20);

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
        child: Text("Change",
            style: TextStyle(fontSize: fontSize, color: Colors.white)),
      ),
    );
  }
}
