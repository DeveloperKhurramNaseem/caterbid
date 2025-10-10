import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'tab_selector.dart';

class HeaderWithTabs extends StatelessWidget {
  final bool isActiveTab;
  final VoidCallback onActiveTap;
  final VoidCallback onFulfilledTap;

  const HeaderWithTabs({
    super.key,
    required this.isActiveTab,
    required this.onActiveTap,
    required this.onFulfilledTap,
  });

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          "My Requests",
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
            
            fontSize: 20,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(width: h * 0.01),
        TabSelector(
          leftLabel: "Active",
          rightLabel: "Fulfilled",
          isLeftSelected: isActiveTab,
          onLeftTap: onActiveTap,
          onRightTap: onFulfilledTap,
        ),
      ],
    );
  }
}
