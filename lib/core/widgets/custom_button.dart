import 'package:flutter/material.dart';
import '../../../../../core/config/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final Widget? child;
  final VoidCallback? onPressed;
  final bool isEnabled;
  final double borderRadius;

  const CustomButton({
    super.key,
    this.title,
    this.child,
    this.onPressed,
    this.isEnabled = true,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? AppColors.c500 : Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: isEnabled ? onPressed : null,
        child: child ?? Text(
          title ?? '',
          style: const TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
