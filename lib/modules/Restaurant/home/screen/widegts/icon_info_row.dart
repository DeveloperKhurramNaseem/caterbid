import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class IconInfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconInfoRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    final textSize = Responsive.responsiveSize(context, 12, 13, 14);
    final iconSize = Responsive.responsiveSize(context, 16, 18, 20);
    final gap = Responsive.responsiveSize(context, 6, 8, 10);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start, //  Align icon to top of text
      children: [
        Padding(
          padding: EdgeInsets.only(top: 1), // fine-tune vertical alignment
          child: Icon(icon, size: iconSize, color: AppColors.icon),
        ),
        SizedBox(width: gap),
        Flexible(
          child: Text(
            text,
            style: TextStyle(fontSize: textSize, color: Colors.black54),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            softWrap: true, //  allow proper wrapping
          ),
        ),
      ],
    );
  }
}
