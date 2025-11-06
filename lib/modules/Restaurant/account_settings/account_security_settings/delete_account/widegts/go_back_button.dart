import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class GoBackButton extends StatelessWidget {
  final VoidCallback onPressed;

  const GoBackButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final height = Responsive.responsiveSize(context, 50, 56, 64);
    final fontSize = Responsive.responsiveSize(context, 16, 18, 20);

    return SizedBox(
      width: double.infinity,
      height: height,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: const BorderSide(color: Colors.orange),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          'Go Back',
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.orange,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
