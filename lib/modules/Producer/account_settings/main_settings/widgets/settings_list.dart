import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/sheet/main_screen/account_security_sheet.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'setting_tile.dart';

class SettingsList extends StatelessWidget {
  const SettingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Settings',
        //   style: TextStyle(
        //     fontSize: 20,
        //     fontWeight: FontWeight.w600,
        //   ),
        // ),
        // SizedBox(height: 5),
        SettingTile(
          iconPath: 'assets/icons/account_icon.png',
          label: 'Account/Security Settings',
          onTap: () {
            AccountSecuritySheet.show(context);
          },
        ),
        SettingTile(
          iconPath: 'assets/icons/privacy_icon.png',
          label: 'Privacy Policy',
          onTap: () {
            // TODO: show privacy policy
          },
        ),
        SettingTile(
          iconPath: 'assets/icons/terms_icon.png',
          label: 'Terms & Conditions',
          onTap: () {
            // TODO: show terms & conditions
          },
        ),
        SettingTile(
          iconPath: 'assets/icons/logout_icon.png',
          label: 'Log Out',
          onTap: (){
            SecureStorage.clearToken();
            context.go(LoginScreen.path);
          },
        ),
      ],
    );
  }
}
