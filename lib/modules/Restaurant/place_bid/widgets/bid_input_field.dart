import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class BidInputField extends StatelessWidget {
  final String label;
  final Widget? suffixIcon;
  final int maxLines;

  const BidInputField({
    super.key,
    required this.label,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final radius = Responsive.responsiveSize(context, 8, 10, 12);
    final fontSize = Responsive.responsiveSize(context, 14, 16, 18);

    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        labelStyle:
            TextStyle(fontSize: fontSize, color: Colors.grey[700]),
        suffixIcon: suffixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radius),
          borderSide: const BorderSide(color: Colors.teal),
        ),
      ),
    );
  }
}
