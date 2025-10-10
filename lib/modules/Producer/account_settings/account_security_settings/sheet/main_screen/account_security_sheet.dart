import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/screen/change_password.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/screen/delete_account_screen.dart.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/sheet/widgets/setting_tile.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/sheet/widgets/sheet_header.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';


class AccountSecuritySheet {
  static void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.appBackground,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      transitionAnimationController: AnimationController(
        duration: const Duration(milliseconds: 350),
        vsync: Navigator.of(context),
      ),
      builder: (_) => const _AccountSecurityContent(),
    );
  }
}

class _AccountSecurityContent extends StatelessWidget {
  const _AccountSecurityContent();

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    final w = Responsive.width(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * 0.05, vertical: h * 0.02),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SheetHeader(title: "Account/Security Settings",),
          SizedBox(height: h * 0.02),
          SettingTile(
            title: "Change Password",
            showArrow: true,
            onTap: () {
              Navigator.of(context).pop(); 
              context.push(ChangePasswordScreen.path);
            },
          ),
          SizedBox(height: h * 0.015),
          SettingTile(
            title: "Delete Account",
            isDestructive: true,
            onTap: () {
              Navigator.of(context).pop(); 
              context.push(DeleteAccountScreen.path);
            },
          ),
          SizedBox(height: h * 0.03),
        ],
      ),
    );
  }
}
