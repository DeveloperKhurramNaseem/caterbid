import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:caterbid/core/utils/helpers/storage/prefs/user_session.dart';
import 'package:caterbid/core/widgets/app_logo.dart';
import 'package:caterbid/core/widgets/error_banner.dart';
import 'package:caterbid/core/widgets/loader_overlay.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/bloc/requestee_profile_bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/bloc/provider_profile_bloc.dart';
import 'package:caterbid/modules/auth/login/bloc/login_bloc.dart';
import 'package:caterbid/modules/auth/login/model/login_request_model.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_button.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_email_field.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_forgot_password.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_password_field.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_signup_text.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_welcome_text.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Restaurant/business_profile/screen/main_screen/set_business_profile_screen.dart';
import 'package:caterbid/modules/Restaurant/home/screen/main_screen/bids_home.dart';
import 'package:caterbid/modules/auth/verify_email_screen/screen/main_screen/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  static const path = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _onLoginPressed() {
    FocusScope.of(context).unfocus();

    if (_formKey.currentState!.validate()) {
      final model = LoginRequestModel(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      context.read<LoginBloc>().add(LoginButtonPressed(model));
    }
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          final user = state.user;

          UserSession.setRole(user.role);

          if (user.role == 'requestee') {
            context.read<RequesteeProfileBloc>().add(
              LoadRequesteeProfileEvent(),
            );

            context.go(ProducerHomeScreen.path);
          } else if (user.role == 'provider') {
            context.read<ProviderProfileBloc>().add(LoadProviderProfileEvent());

            if (user.locationRequired == true) {
              context.go(SetBusinessProfileScreen.path);
            } else {
              context.go(MyBidsScreen.path);
            }
          }
        } else if (state is LoginEmailNotVerified) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.user.email)));

          context.push(
            VerifyEmailScreen.path,
            extra: {'email': state.user.email, 'role': state.user.role},
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;
        String? errorMessage;

        if (state is LoginFailure) {
          errorMessage = state.error;
        }

        return LoaderOverlay(
          isLoading: isLoading,

          child: Scaffold(
            appBar: AppLogoAppBar(),
            backgroundColor: AppColors.appBackground,
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: h * 0.05),

                          if (errorMessage != null)
                            ErrorBanner(message: errorMessage),
                          SizedBox(height: h * 0.02),
                          const LoginWelcomeText(),
                          SizedBox(height: h * 0.03),
                          LoginEmailField(controller: _emailController),
                          SizedBox(height: h * 0.02),
                          LoginPasswordField(controller: _passwordController),
                          SizedBox(height: h * 0.02),
                          const LoginForgotPassword(),
                          SizedBox(height: h * 0.04),
                          LoginButton(
                            isLoading: isLoading,
                            onPressed: _onLoginPressed,
                          ),
                          SizedBox(height: h * 0.03),
                          const LoginSignupText(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
