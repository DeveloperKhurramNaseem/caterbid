import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/sheet/main_screen/account_security_sheet.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'provider_setting_tile.dart';

class ProviderSettingsList extends StatelessWidget {
  
  const ProviderSettingsList({super.key});

    Future<void> _confirmLogout(BuildContext context) async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text(
            'Confirm Logout',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Log Out'),
            ),
          ],
        );
      },
    );

    // 👇 Add mounted check here
    if (shouldLogout == true && context.mounted) {
      context.read<ProviderProfileBloc>().add(LogoutProviderProfileEvent());

      // small delay for smooth UX (optional)
      await Future.delayed(const Duration(milliseconds: 200));

      if (context.mounted) {
        context.go(LoginScreen.path);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProviderSettingTile(
          iconPath: 'assets/icons/account_icon.png',
          label: 'Account/Security Settings',
          onTap: () {
            ProvidorAccountSecuritySheet.show(context);
          },
        ),
        ProviderSettingTile(
          iconPath: 'assets/icons/privacy_icon.png',
          label: 'Privacy Policy',
          onTap: () {},
        ),
        ProviderSettingTile(
          iconPath: 'assets/icons/terms_icon.png',
          label: 'Terms & Conditions',
          onTap: () {},
        ),
        ProviderSettingTile(
          iconPath: 'assets/icons/logout_icon.png',
          label: 'Log Out',
          onTap: () async => _confirmLogout(context),

        ),
      ],
    );
  }
}
