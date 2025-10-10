import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';

class SettingTile extends StatelessWidget {
  final String title;
  final bool showArrow;
  final bool isDestructive;
  final VoidCallback? onTap;

  const SettingTile({
    super.key,
    required this.title,
    this.showArrow = false,
    this.isDestructive = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    final fSize = Responsive.responsiveSize(context, 15, 17, 19);

    return InkWell(
      onTap: onTap, // 👈 Tap action here
      borderRadius: BorderRadius.circular(12),
      splashColor: Colors.grey.withOpacity(0.1),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: h * 0.018,
          horizontal: h * 0.02,
        ),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontFamily: AppFonts.nunito,
                fontSize: fSize,
                fontWeight: FontWeight.w500,
                color: isDestructive ? Colors.redAccent : AppColors.textDark,
              ),
            ),
            if (showArrow)
              const Icon(Icons.arrow_forward_ios, color: Colors.black, size: 16),
          ],
        ),
      ),
    );
  }
}
