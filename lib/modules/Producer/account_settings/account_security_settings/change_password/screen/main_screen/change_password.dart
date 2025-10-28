import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/change_password_bloc.dart';
import '../../repository/requestee_change_password.dart';
import '../widgets/requestee_change_password_title.dart';
import '../widgets/requestee_change_password_fields.dart';
import '../widgets/requestee_password_requirements.dart';
import '../widgets/requestee_change_password_button.dart';

class RequesteeSettingsChangePassword extends StatelessWidget {
  static const path = '/requestee/change-password';
  const RequesteeSettingsChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (_) => ChangePasswordBloc(RequesteeChangePasswordRepository()),
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully!')),
            );
            context.pop();
            oldPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          }
        },
        builder: (context, state) {
          final bloc = context.read<ChangePasswordBloc>();

          return Scaffold(
            backgroundColor: AppColors.appBackground,
            appBar: const NavigationbarTitle(title: 'Change Password'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const RequesteeChangePasswordTitle(),
                  RequesteeChangePasswordFields(
                    oldPasswordController: oldPasswordController,
                    newPasswordController: newPasswordController,
                    confirmPasswordController: confirmPasswordController,
                    onPasswordChanged: (newPassword, confirmPassword) {
                      bloc.add(
                        ValidatePasswordEvent(newPassword, confirmPassword),
                      );
                    },
                  ),

                  RequesteePasswordRequirements(
                    isValidLength: state.isValidLength,
                    hasUpperCase: state.hasUpperCase,
                    hasLowerCase: state.hasLowerCase,
                    hasNumberOrSymbol: state.hasNumberOrSymbol,
                  ),
                  const SizedBox(height: 32),
                  RequesteeChangePasswordButton(
                    state: state,
                    onPressed: () {
                      bloc.add(
                        SubmitChangePasswordEvent(
                          currentPassword: oldPasswordController.text,
                          newPassword: newPasswordController.text,
                          confirmPassword: confirmPasswordController.text,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
