import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Producer/account_settings/main_settings/widgets/custom_appbar.dart';
import 'package:caterbid/modules/Producer/account_settings/main_settings/widgets/header_profile.dart';
import 'package:caterbid/modules/Producer/account_settings/main_settings/widgets/settings_list.dart';
import 'package:caterbid/modules/Producer/account_settings/main_settings/widgets/version_label.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class SettingsScreen extends StatelessWidget {
  static const path = '/settingscreen';
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.responsiveSize(context, 16, 24, 32);
    final topSpacing = Responsive.responsiveSize(context, 12, 16, 22);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const SettingsAppBar(title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: Column(
            children: [
              SizedBox(height: topSpacing),
              const HeaderProfile(),      
              SizedBox(height: topSpacing),
              const Divider(thickness: 0.3, color: Colors.grey),
              SizedBox(height: Responsive.responsiveSize(context, 12, 14, 18)),
              const SettingsList(),       
              const Spacer(),
              const VersionLabel(),       // version text at bottom
              SizedBox(height: Responsive.responsiveSize(context, 10, 14, 18)),
            ],
          ),
        ),
      ),
    );
  }
}


