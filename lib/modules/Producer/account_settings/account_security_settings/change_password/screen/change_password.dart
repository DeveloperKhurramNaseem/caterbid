import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/widgets/change_button.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/widgets/password_requirements.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/widgets/password_text_field.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/config/app_colors.dart';


class settingsChangePassword extends StatefulWidget {
  static const path = '/changepassword';
  const settingsChangePassword({super.key});

  @override
  State<settingsChangePassword> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<settingsChangePassword> {
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
                      color: AppColors.textDark)),

              SizedBox(height: 4),
              Text("Use at least 8 characters including letters and numbers",
                  style: TextStyle(
                    fontFamily: AppFonts.nunito,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textDark,
                      fontSize: Responsive.responsiveSize(context, 16, 17, 18))),

              SizedBox(height: 24),
              PasswordField(
                label: "Old Password",
                controller: oldPasswordController,
              ),
              SizedBox(height: 16),
              PasswordField(
                label: "New Password",
                controller: newPasswordController,
                onChanged: _validatePassword,
              ),
              SizedBox(height: 16),
              PasswordField(
                label: "Confirm New Password",
                controller: confirmPasswordController,
                onChanged: _validatePassword,),
              SizedBox(height: 24),

              PasswordRequirements(
                isValidLength: isValidLength,
                hasUpperCase: hasUpperCase,
                hasLowerCase: hasLowerCase,
                hasNumberOrSymbol: hasNumberOrSymbol,
              ),

              SizedBox(height: 32),
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
