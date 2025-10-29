import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/utils/user_session.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/main_settings/main_screen/requestee_setting_screen.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/main_settings/screen/provider_settings_screen.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/bloc/requestee_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final radius = Responsive.responsiveSize(context, 18, 22, 28);
    final padding = Responsive.responsiveSize(context, 10, 12, 14);

    final bool isRequestee = UserSession.isRequestee;
    final bool isProvider = UserSession.isProvider;

    return Padding(
      padding: EdgeInsets.all(padding),
      child: GestureDetector(
        onTap: () {
          print("Avatar tapped! isProvider: $isProvider");

          if (isProvider) {
            final route = ProviderSettingsScreen.path;
            print("Pushing route: $route");
            final canPush = context.push(route);
            print("Push result: $canPush");
          } else if (isRequestee) {
            context.push(RequesteeSettingsScreen.path);
          }
        },
        // 👇 Only one BlocBuilder will ever be created
        child: Builder(
          builder: (_) {
            if (isProvider) {
              return BlocBuilder<ProviderProfileBloc, ProviderProfileState>(
                builder: (context, state) =>
                    _buildProviderAvatar(state, radius),
              );
            } else {
              return BlocBuilder<RequesteeProfileBloc, RequesteeProfileState>(
                builder: (context, state) =>
                    _buildRequesteeAvatar(state, radius),
              );
            }
          },
        ),
      ),
    );
  }

  // ✅ Provider Avatar Builder
  Widget _buildProviderAvatar(ProviderProfileState state, double radius) {
    if (state is ProviderProfileLoaded) {
      final user = state.user;
      final name = user.name ?? '';
      final hasImage = user.profilePicture?.isNotEmpty ?? false;

      return CircleAvatar(
        radius: radius,
        backgroundImage: hasImage ? NetworkImage(user.profilePicture!) : null,
        backgroundColor: hasImage ? null : AppColors.c300,
        child: !hasImage
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : '',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: radius * 0.9,
                ),
              )
            : null,
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade300,
      child: const Icon(Icons.person, color: Colors.white),
    );
  }

  // ✅ Requestee Avatar Builder
  Widget _buildRequesteeAvatar(RequesteeProfileState state, double radius) {
    if (state is RequesteeProfileLoaded) {
      final user = state.user;
      final name = user.name ?? '';
      final hasImage = user.profilePicture?.isNotEmpty ?? false;

      return CircleAvatar(
        radius: radius,
        backgroundImage: hasImage ? NetworkImage(user.profilePicture!) : null,
        backgroundColor: hasImage ? null : AppColors.c300,
        child: !hasImage
            ? Text(
                name.isNotEmpty ? name[0].toUpperCase() : 'R',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: radius * 0.9,
                ),
              )
            : null,
      );
    }
    return CircleAvatar(
      radius: radius,
      backgroundColor: Colors.grey.shade300,
      child: const Icon(Icons.person, color: Colors.white),
    );
  }
}
