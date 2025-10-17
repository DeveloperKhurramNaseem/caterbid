import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/app_logo.dart';
import 'package:caterbid/core/widgets/loader_overlay.dart';
import 'package:caterbid/modules/auth/login/bloc/login_bloc.dart';
import 'package:caterbid/modules/auth/login/model/login_request_model.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_button.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_email_field.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_forgot_password.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_password_field.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_signup_text.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_welcome_text.dart';
import 'package:caterbid/modules/Producer/home/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Restaurant/business_profile/main_screen/set_business_profile_screen.dart';
import 'package:caterbid/modules/Restaurant/home/main_screen/bids_home.dart';
import 'package:caterbid/modules/auth/verify_email_screen/main_screen/verify_email_screen.dart';
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
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          final user = state.user;
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Welcome ${user.email}!')));

          if (user.role == 'requestee') {
            context.go(ProducerHomeScreen.path);
          } else if (user.role == 'provider') {
            if (user.locationRequired == true) {
              context.go(SetBusinessProfileScreen.path);
            } else {
              context.go(MyBidsScreen.path);
            }
          }
        } else if (state is LoginEmailNotVerified) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.user.email)));

          context.push(
            VerifyEmailScreen.path,
            extra: {
              'email': state.user.email,
              'role': 'requestee', // Hardcoded for testing
            },
          );
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

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
                          const SizedBox(height: 40),
                          const LoginWelcomeText(),
                          const SizedBox(height: 40),
                          LoginEmailField(controller: _emailController),
                          const SizedBox(height: 20),
                          LoginPasswordField(controller: _passwordController),
                          const SizedBox(height: 10),
                          const LoginForgotPassword(),
                          const SizedBox(height: 40),
                          LoginButton(
                            isLoading: isLoading,
                            onPressed: _onLoginPressed,
                          ),
                          const SizedBox(height: 20),
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
