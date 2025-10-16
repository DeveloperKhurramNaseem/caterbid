import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/app_logo.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_button.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_email_field.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_forgot_password.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_password_field.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_signup_text.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_welcome_text.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/modules/auth/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return OverlayLoaderWithAppIcon(
          isLoading: isLoading,
          appIcon: Image.asset(
            'assets/icons/app_icon.png',
            width: 80,
            height: 80,
          ),
          circularProgressColor: AppColors.c500,
          overlayBackgroundColor: Colors.black.withOpacity(0.4),
          child: AbsorbPointer(
            absorbing: isLoading, //  disables all taps behind the overlay

            child: Scaffold(
              appBar: AppLogoAppBar(),
              backgroundColor: AppColors.appBackground,
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 40),
                            const LoginWelcomeText(),
                            SizedBox(height: 40),
                            LoginEmailField(controller: _emailController),
                            SizedBox(height: 20),
                            LoginPasswordField(controller: _passwordController),
                            SizedBox(height: 10),
                            const LoginForgotPassword(),
                            SizedBox(height: 40),
                            LoginButton(
                              emailController: _emailController,
                              passwordController: _passwordController,
                              formKey: _formKey,
                            ),
                            SizedBox(height: 20),
                            const LoginSignupText(),
                          ],
                        ),
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
