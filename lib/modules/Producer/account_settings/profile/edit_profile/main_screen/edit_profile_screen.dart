import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/bloc/requestee_profile_bloc.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/profile_form.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/edit_profile/widgets/editing_appbar.dart';

class RequesteeEditProfileScreen extends StatelessWidget {
  static const path = '/requestee_edit_profile';

  const RequesteeEditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const EditingAppbar(title: 'Edit Profile'),
      body: SafeArea(
        child: BlocConsumer<RequesteeProfileBloc, RequesteeProfileState>(
          listener: (context, state) {
            if (state is RequesteeProfileLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully')),
              );
              context.pop();
            } else if (state is RequesteeProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is RequesteeProfileLoading;
            final user = (state is RequesteeProfileLoaded)
                ? state.user
                : (state is RequesteeProfileUpdatingKeepOld)
                    ? state.user
                    : null;

            return isLoading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ProfileForm(user: user),
                  );
          },
        ),
      ),
    );
  }
}
