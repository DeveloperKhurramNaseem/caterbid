import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';

class ProviderSettingTile extends StatelessWidget {
  final String iconPath; 
  final String label;
  final VoidCallback onTap;

  const ProviderSettingTile({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double circleSize = Responsive.responsiveSize(context, 38, 44, 52);
    final double iconSize = Responsive.responsiveSize(context,  55, 26, 30);
    final double fontSize = Responsive.responsiveSize(context, 18, 20, 22);
    final double verticalPadding = Responsive.responsiveSize(context, 2, 12, 14);
    final double spacing = Responsive.responsiveSize(context, 7, 16, 18);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: verticalPadding),
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.all(circleSize * 0.2),
                child: Image.asset(
                  iconPath,
                  width: iconSize,
                  height: iconSize,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(width: spacing),
              Expanded(
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: fontSize,
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ),
              Icon(
                Icons.chevron_right,
                color: Colors.grey,
                size: Responsive.responsiveSize(context, 20, 22, 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
