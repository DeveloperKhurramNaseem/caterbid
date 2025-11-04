import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/delete_account/bloc/provider_delete_account_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/delete_account/repository/providor_delete_account.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/delete_account/widegts/delete_account_button.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/delete_account/widegts/delete_account_icon.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/delete_account/widegts/delete_account_message.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/delete_account/widegts/go_back_button.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/repository/provider_profile_repository.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class ProviderDeleteAccountScreen extends StatelessWidget {
  static const String path = '/providerdeleteaccount';
  const ProviderDeleteAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProviderDeleteAccountBloc(
        ProvidorDeleteAccount(),
        ProviderRepository(),
      ),
      child: BlocListener<ProviderDeleteAccountBloc, ProviderDeleteAccountState>(
        listener: (context, state) async {
          if (state is ProvidorDeleteAccountSuccess) {
            // Navigate to login screen
            context.go(LoginScreen.path);
          } else if (state is ProvidorDeleteAccountFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Scaffold(
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
                BlocBuilder<ProviderDeleteAccountBloc, ProviderDeleteAccountState>(
                  builder: (context, state) {
                    return state is ProvidorDeleteAccountLoading
                        ? const CircularProgressIndicator(
                          color: AppColors.c400,
                        )
                        : DeleteAccountButton(
                            onPressed: () {
                              context.read<ProviderDeleteAccountBloc>().add(ProviderDeleteAccountRequested());
                            },
                          );
                  },
                ),
                SizedBox(height: Responsive.responsiveSize(context, 16, 24, 32)),
                GoBackButton(onPressed: () => Navigator.pop(context)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
