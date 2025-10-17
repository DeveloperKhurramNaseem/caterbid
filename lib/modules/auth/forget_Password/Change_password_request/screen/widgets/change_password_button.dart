import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';

class ChangePasswordButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const ChangePasswordButton({
    super.key,
    required this.isLoading,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220,
      height: 48,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.c500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed:  onPressed,
        child: const Text(
                "Continue",
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
      ),
    );
  }
}

//TO make button disable just for ui purpose not confirm yet: isLoading ? null :