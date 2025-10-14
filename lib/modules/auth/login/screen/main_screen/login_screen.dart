import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_email_field.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_password_field.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_button.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_title.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_welcome_text.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_forgot_password.dart';
import 'package:caterbid/modules/auth/login/screen/widgets/login_signup_text.dart';

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
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.02),
                    const LoginTitle(),
                    SizedBox(height: h * 0.04),
                    const LoginWelcomeText(),
                    SizedBox(height: h * 0.04),
                    LoginEmailField(controller: _emailController),
                    SizedBox(height: h * 0.02),
                    LoginPasswordField(controller: _passwordController),
                    SizedBox(height: h * 0.01),
                    LoginForgotPassword(),
                    SizedBox(height: h * 0.04),
                    LoginButton(
                      emailController: _emailController,
                      passwordController: _passwordController,
                      formKey: _formKey,
                    ),
                    SizedBox(height: h * 0.02),
                    const LoginSignupText(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
