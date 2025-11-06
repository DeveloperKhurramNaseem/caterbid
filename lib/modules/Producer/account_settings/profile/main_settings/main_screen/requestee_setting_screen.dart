import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/bloc/requestee_profile_bloc.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/main_settings/widgets/custom_appbar.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/main_settings/widgets/header_profile.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/main_settings/widgets/settings_list.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/main_settings/widgets/version_label.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RequesteeSettingsScreen extends StatelessWidget {
  static const path = '/requestee_settings';
  const RequesteeSettingsScreen({super.key});

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

              // Profile header (auto-updates)
              BlocBuilder<RequesteeProfileBloc, RequesteeProfileState>(
                builder: (context, state) {
                  if (state is RequesteeProfileLoaded) {
                    return HeaderProfile(
                      name: state.user.name ?? 'User',
                      profileImageUrl: state.user.profilePicture,
                      firstLetter: state.user.firstLetter,
                    );
                  } else if (state is RequesteeProfileLoading) {
                    return const HeaderProfile.loading();
                  }
                  return const HeaderProfile(
                    name: 'Unknown User',
                    profileImageUrl: null,
                    firstLetter: '?',
                  );
                },
              ),

              SizedBox(height: topSpacing),
              const Divider(thickness: 0.3, color: Colors.grey),
              SizedBox(height: Responsive.responsiveSize(context, 12, 14, 18)),

              // Settings list with logout
              BlocListener<RequesteeProfileBloc, RequesteeProfileState>(
                listener: (context, state) {
                  if (state is RequesteeProfileInitial) {
                    context.go(LoginScreen.path);
                  }
                },
                child: const SettingsList(),
              ),

              const Spacer(),
              const VersionLabel(),
              SizedBox(height: Responsive.responsiveSize(context, 10, 14, 18)),
            ],
          ),
        ),
      ),
    );
  }
}
