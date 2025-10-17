import 'package:caterbid/core/widgets/loader_overlay.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/bloc/change_password_request_bloc.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/model/change_password_request.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/screen/widgets/change_password_button.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/screen/widgets/change_password_confirm_field.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/screen/widgets/change_password_description.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/screen/widgets/change_password_new_field.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/screen/widgets/change_password_title.dart';
import 'package:go_router/go_router.dart';

class ChangePasswordScreen extends StatelessWidget {
  static const path = '/change_password';
  final String email;

  const ChangePasswordScreen({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return BlocConsumer<ChangePasswordRequestBloc, ChangePasswordRequestState>(
      listener: (context, state) {
        if (state is ChangePasswordSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Password changed successfully!")),
          );
          context.go(LoginScreen.path);
        } else if (state is ChangePasswordFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is ChangePasswordLoading;

        void onChangePasswordPressed() {
          final newPass = newPasswordController.text.trim();
          final confirmPass = confirmPasswordController.text.trim();

          if (newPass.isEmpty || confirmPass.isEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please fill all fields")),
            );
            return;
          }
          if (newPass != confirmPass) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Passwords do not match")),
            );
            return;
          }

          final request = ChangePasswordRequest(
            email: email,
            newPassword: newPass,
          );

          context.read<ChangePasswordRequestBloc>().add(
                SubmitChangePassword(request),
              );
        }

        return LoaderOverlay(
          isLoading: isLoading,
          child: Scaffold(
            backgroundColor: AppColors.appBackground,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              automaticallyImplyLeading: true,
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.05),
                  const ChangePasswordTitle(),
                  ChangePasswordDescription(email: email),
                  SizedBox(height: h * 0.04),
                  ChangePasswordNewField(controller: newPasswordController),
                  SizedBox(height: h * 0.02),
                  ChangePasswordConfirmField(controller: confirmPasswordController),
                  SizedBox(height: h * 0.05),
                  Center(
                    child: ChangePasswordButton(
                      isLoading: isLoading,
                      onPressed: onChangePasswordPressed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
