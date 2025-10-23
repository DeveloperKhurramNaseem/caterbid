import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/core/widgets/password_widget/password_requirements.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/screen/widgets/change_button.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/screen/widgets/change_password_confirm_field.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/screen/widgets/old_password_field.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/screen/widgets/change_password_new_field.dart';
import 'package:flutter/material.dart';

class SettingsChangePassword extends StatefulWidget {
  static const path = '/changepassword';
  const SettingsChangePassword({super.key});

  @override
  State<SettingsChangePassword> createState() => _SettingsChangePasswordState();
}

class _SettingsChangePasswordState extends State<SettingsChangePassword> {
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isValidLength = false;
  bool hasUpperCase = false;
  bool hasLowerCase = false;
  bool hasNumberOrSymbol = false;

  void _validatePassword(String password) {
    setState(() {
      isValidLength = password.length >= 8;
      hasUpperCase = password.contains(RegExp(r'[A-Z]'));
      hasLowerCase = password.contains(RegExp(r'[a-z]'));
      hasNumberOrSymbol = password.contains(RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]'));
    });
  }

  @override
  Widget build(BuildContext context) {
    double fontSizeTitle = Responsive.responsiveSize(context, 18, 20, 22);
    double padding = Responsive.responsiveSize(context, 25, 30, 35);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const NavigationbarTitle(title: 'Change Password'),
      body: Padding(
        padding: EdgeInsets.all(padding),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Change Password",
                  style: TextStyle(
                    fontFamily: AppFonts.nunito,
                    fontWeight: FontWeight.w700,
                    fontSize: fontSizeTitle,
                    color: AppColors.textDark,
                  )),
              const SizedBox(height: 4),
              Text(
                "Use at least 8 characters including letters and numbers",
                style: TextStyle(
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textDark,
                  fontSize: Responsive.responsiveSize(context, 16, 17, 18),
                ),
              ),
              const SizedBox(height: 24),

              // old password field
              OldPasswordField(
                controller: oldPasswordController,
              ),

              const SizedBox(height: 16),

              // new password field with live validation
              ChangePasswordNewField(
                controller: newPasswordController,
                onChanged: _validatePassword,
              ),

              const SizedBox(height: 16),

              // confirm password field (optional validation)
              ChangePasswordConfirmField(
                controller: confirmPasswordController,
                onChanged: _validatePassword,
              ),

              const SizedBox(height: 24),

              // show requirements based on _validatePassword
              PasswordRequirements(
                isValidLength: isValidLength,
                hasUpperCase: hasUpperCase,
                hasLowerCase: hasLowerCase,
                hasNumberOrSymbol: hasNumberOrSymbol,
              ),

              const SizedBox(height: 32),
              ChangeButton(
                onPressed: () {
                  // TODO: Add change password logic
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
