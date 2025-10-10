import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/app_logo.dart';
import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:caterbid/modules/Restaurant/business_profile/main_screen/set_business_profile_screen.dart';
import 'package:caterbid/modules/auth/screens/signup/signup_screen/widget/signup_footer.dart';
import 'package:caterbid/modules/auth/screens/signup/signup_screen/widget/signup_form.dart';
import 'package:caterbid/modules/auth/screens/signup/signup_screen/widget/signup_heading.dart';
import 'package:caterbid/modules/auth/screens/signup/verify_email_screen/main_screen/verify_email_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatelessWidget {
  static const path = '/';
  const SignUpScreen({super.key});

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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.02),
                  Center(child: const AppLogo()),
                  SizedBox(height: h * 0.04),
                  const SignUpHeading(),
                  SizedBox(height: h * 0.03),
                  const SignUpForm(),
                  SizedBox(height: h * 0.03),
                  const SignUpFooter(),
                  SizedBox(height: h * 0.05),

                  CustomButton(
                    title: 'for Testing verify email',
                    isEnabled: true,
                    onPressed: () {
                      context.push(VerifyEmailScreen.path);
                    },
                  ),
                  SizedBox(height: h * 0.02),
                  CustomButton(
                    title: 'for Testing business profile',
                    isEnabled: true,
                    onPressed: () {
                      context.push(SetBusinessProfileScreen.path);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
