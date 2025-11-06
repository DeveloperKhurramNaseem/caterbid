import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class InfoText extends StatelessWidget {
  // final String? label;
  final String value;
  final Color? color;
  final FontWeight? fontWeight;

  const InfoText({
    super.key,
    // this.label,
    required this.value,
    this.color,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          fontSize: Responsive.responsiveSize(context, 12, 13, 14),
          color: color ?? Colors.grey.shade700,
          fontWeight: fontWeight ?? FontWeight.w500,
        ),
        children: [
          TextSpan(
            // text: "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Colors.grey.shade800,
            ),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}
