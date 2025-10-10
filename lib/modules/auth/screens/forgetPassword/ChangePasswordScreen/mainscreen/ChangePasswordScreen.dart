import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/ChangePasswordScreen/widgets/change_password_button.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/ChangePasswordScreen/widgets/change_password_confirm_field.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/ChangePasswordScreen/widgets/change_password_description.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/ChangePasswordScreen/widgets/change_password_new_field.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/ChangePasswordScreen/widgets/change_password_title.dart';
import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const path = '/change_password';
  final String email; // passed email
  const ChangePasswordScreen({super.key, required this.email});

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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.05),
              const ChangePasswordTitle(),
              ChangePasswordDescription(email: email),
              SizedBox(height: h * 0.04),
              const ChangePasswordNewField(),
              SizedBox(height: h * 0.02),
              const ChangePasswordConfirmField(),
              SizedBox(height: h * 0.05),
              const Center(child: ChangePasswordButton()),
            ],
          ),
        ),
      ),
    );
  }
}
