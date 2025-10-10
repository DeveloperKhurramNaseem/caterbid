import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';

class CateringSubmitButton extends StatelessWidget {
  final VoidCallback onPressed;

  const CateringSubmitButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.c500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          'Create Request',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
