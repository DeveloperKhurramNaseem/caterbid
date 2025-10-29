import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/edit_profile/widget/provider_profile_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/profile_form.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/editing_appbar.dart';

class ProviderEditProfileScreen extends StatelessWidget {
  static const path = '/provider_edit_profile';

  const ProviderEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const EditingAppbar(title: 'Edit Profile'),
      body: SafeArea(
        child: BlocConsumer<ProviderProfileBloc, ProviderProfileState>(
          listener: (context, state) {
            if (state is ProviderProfileLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
              context.pop();
            } else if (state is ProviderProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is ProviderProfileLoading;
            final user = (state is ProviderProfileLoaded)
                ? state.user
                : (state is ProviderProfileUpdatingKeepOld)
                    ? state.user
                    : null;

            return isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ProviderProfileForm(user: user),
                  );
          },
        ),
      ),
    );
  }
}