import 'package:caterbid/modules/Producer/account_settings/main_settings/main_screen/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    double radius = Responsive.responsiveSize(context, 18, 22, 28);
    double padding = Responsive.responsiveSize(context, 10, 12, 14);

    return Padding(
      padding: EdgeInsets.all(padding),
      child: GestureDetector(
        onTap: () {
          context.push(SettingsScreen.path);
        },
        child: CircleAvatar(
          backgroundImage: const AssetImage('assets/images/dummy_profile.jpg'),
          radius: radius,
        ),
      ),
    );
  }
}
