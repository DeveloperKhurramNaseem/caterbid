import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/bloc/requestee_delete_account_bloc.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/repository/delete_account_repository.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/widegts/delete_account_button.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/widegts/delete_account_icon.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/widegts/delete_account_message.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/delete_account/widegts/go_back_button.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/repository/requestee_profile_repository.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RequesteeDeleteAccountScreen extends StatelessWidget {
  static const String path = '/deleteaccount';
  const RequesteeDeleteAccountScreen({super.key});

@override
Widget build(BuildContext context) {
  return BlocProvider(
    create: (_) => RequesteeDeleteAccountBloc(RequesteeDeleteAccountRepository(),RequesteeRepository() ),
    child: BlocListener<RequesteeDeleteAccountBloc, RequesteeDeleteAccountState>(
      listener: (context, state) {
        if (state is RequesteeDeleteAccountSuccess) {
          // Navigate to login screen
          context.go(LoginScreen.path);
        } else if (state is RequesteeDeleteAccountFailure) {
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
              BlocBuilder<RequesteeDeleteAccountBloc, RequesteeDeleteAccountState>(
                builder: (context, state) {
                  return state is RequesteeDeleteAccountLoading
                      ? const CircularProgressIndicator(
                        color: AppColors.c400,
                      )
                      : DeleteAccountButton(
                          onPressed: () {
                            context.read<RequesteeDeleteAccountBloc>().add(RequesteeDeleteAccountRequested());
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