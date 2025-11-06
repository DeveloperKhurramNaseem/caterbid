import 'package:caterbid/core/config/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/core/config/app_constants.dart';

class SheetHeader extends StatelessWidget {
  final String title;
  const SheetHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final fSize = Responsive.responsiveSize(context, 18, 20, 22);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: fSize,
            fontWeight: FontWeight.w600,
            fontFamily: AppFonts.nunito,
            color: AppColors.textDark,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.close, color: Colors.black),
        ),
      ],
    );
  }
}
