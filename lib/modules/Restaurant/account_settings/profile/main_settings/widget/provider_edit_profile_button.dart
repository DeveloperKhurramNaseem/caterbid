import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/main_screen/provider_edit_profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class ProviderEditProfileButton extends StatelessWidget {
  const ProviderEditProfileButton({super.key});

  @override
  Widget build(BuildContext context) {
    final double fontSize = Responsive.responsiveSize(context, 12, 14, 16);
    final double horizontalPadding = Responsive.responsiveSize(context, 10, 12, 14);
    final double verticalPadding = Responsive.responsiveSize(context, 6, 8, 10);
    final double width = Responsive.responsiveSize(context, 120, 140, 160);

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: () {
          context.push(ProviderEditProfileScreen.path);
                },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.c600,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        ),
        child: Text(
          'Edit Profile',
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontSize: fontSize,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
