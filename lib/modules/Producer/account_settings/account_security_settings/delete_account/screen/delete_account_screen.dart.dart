import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/widegts/delete_account_button.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/widegts/delete_account_icon.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/widegts/delete_account_message.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/widegts/go_back_button.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class RequesteeDeleteAccountScreen extends StatelessWidget {
  static const String path = '/deleteaccount';
  const RequesteeDeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const NavigationbarTitle(title: 'Delete Account'),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.responsiveSize(context, 25, 48, 80),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const DeleteAccountIcon(),
            SizedBox(height: Responsive.responsiveSize(context, 24, 36, 48)),
            const DeleteAccountMessage(),
            SizedBox(height: Responsive.responsiveSize(context, 40, 60, 80)),
            DeleteAccountButton(
              onPressed: () {
                // TODO: Handle account deletion
              },
            ),
            SizedBox(height: Responsive.responsiveSize(context, 16, 24, 32)),
            GoBackButton(
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }
}
