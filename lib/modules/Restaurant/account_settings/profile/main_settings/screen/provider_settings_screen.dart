import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/main_settings/widget/provider_custom_appbar.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/main_settings/widget/provider_header_profile.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/main_settings/widget/provider_settings_list.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/main_settings/widget/provider_version_label.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProviderSettingsScreen extends StatelessWidget {
  static const path = '/provider_settings';
  const ProviderSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final horizontal = Responsive.responsiveSize(context, 16, 24, 32);
    final topSpacing = Responsive.responsiveSize(context, 12, 16, 22);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const ProviderCustomAppbar(title: 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontal),
          child: Column(
            children: [
              SizedBox(height: topSpacing),
              BlocBuilder<ProviderProfileBloc, ProviderProfileState>(
                builder: (context, state) {
                  if (state is ProviderProfileLoaded) {
                    return ProviderHeaderProfile(
                      name: state.user.name ?? 'Provider',
                      companyName: state.user.companyName,
                      profileImageUrl: state.user.profilePicture,
                      firstLetter: state.user.firstLetter,
                    );
                  } else if (state is ProviderProfileLoading) {
                    return const ProviderHeaderProfile.loading();
                  }
                  return const ProviderHeaderProfile(
                    name: 'Unknown Provider',
                    profileImageUrl: null,
                    firstLetter: '?',
                  );
                },
              ),
              SizedBox(height: topSpacing),
              const Divider(thickness: 0.3, color: Colors.grey),
              SizedBox(height: Responsive.responsiveSize(context, 12, 14, 18)),
              BlocListener<ProviderProfileBloc, ProviderProfileState>(
                listener: (context, state) {
                  if (state is ProviderProfileInitial) {
                    context.go(LoginScreen.path);
                  }
                },
                child: const ProviderSettingsList(),
              ),
              const Spacer(),
              const ProviderVersionLabel(),
              SizedBox(height: Responsive.responsiveSize(context, 10, 14, 18)),
            ],
          ),
        ),
      ),
    );
  }
}