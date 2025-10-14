import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class TabSelector extends StatelessWidget {
  final String leftLabel;
  final String rightLabel;
  final bool isLeftSelected;
  final VoidCallback onLeftTap;
  final VoidCallback onRightTap;

  const TabSelector({
    super.key,
    required this.leftLabel,
    required this.rightLabel,
    required this.isLeftSelected,
    required this.onLeftTap,
    required this.onRightTap,
  });

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);

    return Container(
      padding: EdgeInsets.all(w * 0.005),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.c500, width: 1), 
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildTab(
            label: leftLabel,
            isSelected: isLeftSelected,
            onTap: onLeftTap,
          ),

          Container(
            height: 18,
            width: 1,
            color: AppColors.textDark.withOpacity(0.4),
            margin: const EdgeInsets.symmetric(horizontal: 6),
          ),

          _buildTab(
            label: rightLabel,
            isSelected: !isLeftSelected,
            onTap: onRightTap,
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontSize: 13,
            fontWeight:
                isSelected ? FontWeight.w600 : FontWeight.normal,
            color: isSelected ? AppColors.icon : AppColors.textDark,
          ),
        ),
      ),
    );
  }
}
