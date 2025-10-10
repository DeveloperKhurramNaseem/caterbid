import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/forgetpassword_screen/widgets/forget_password_button.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/forgetpassword_screen/widgets/forget_password_form.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/forgetpassword_screen/widgets/forget_password_title_section.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const path = '/forget-password';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.05),
                  const ForgetPasswordTitleSection(),
                  SizedBox(height: h * 0.05),
                  ForgetPasswordForm(emailController: _emailController),
                  SizedBox(height: h * 0.06),
                  ForgetPasswordButton(emailController: _emailController),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
