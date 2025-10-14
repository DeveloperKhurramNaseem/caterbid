import 'package:flutter/material.dart';
import '../../../../../core/config/app_colors.dart';

class MarkAsFullfilled extends StatelessWidget {
  final String title;
  final VoidCallback? onPressed;
  final double borderRadius;

  const MarkAsFullfilled({
    super.key,
    required this.title,
    this.onPressed,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: AppColors.c500, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: () {},
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.c500,
          ),
        ),
      ),
    );
  }
}
