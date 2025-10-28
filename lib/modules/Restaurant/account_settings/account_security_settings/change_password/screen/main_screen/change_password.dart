import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/navigationbar_title.dart';
import 'package:go_router/go_router.dart';
import '../../bloc/provider_change_password_bloc.dart';
import '../../repository/change_password_repository.dart';
import '../widgets/provider_change_password_title.dart';
import '../widgets/provider_change_password_fields.dart';
import '../widgets/provider_password_requirements.dart';
import '../widgets/provider_change_password_button.dart';

class ProviderChangePasswordScreen extends StatelessWidget {
  static const path = '/provider/change-password';
  const ProviderChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final oldPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return BlocProvider(
      create: (_) => ProviderChangePasswordBloc(ProviderChangePasswordRepository()),
      child: BlocConsumer<ProviderChangePasswordBloc, ProviderChangePasswordState>(
        listener: (context, state) {
          if (state is ProviderChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Password changed successfully!')),
            );
            context.pop();
            oldPasswordController.clear();
            newPasswordController.clear();
            confirmPasswordController.clear();
          } else if (state.errorMessage != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errorMessage!)),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<ProviderChangePasswordBloc>();

          return Scaffold(
            backgroundColor: AppColors.appBackground,
            appBar: const NavigationbarTitle(title: 'Change Password'),
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ProviderChangePasswordTitle(),
                  ProviderChangePasswordFields(
                    oldPasswordController: oldPasswordController,
                    newPasswordController: newPasswordController,
                    confirmPasswordController: confirmPasswordController,
                    onPasswordChanged: (newPassword, confirmPassword) {
                      bloc.add(
                        ValidatePasswordEvent(newPassword, confirmPassword),
                      );
                    },
                  ),
                  ProviderPasswordRequirements(
                    isValidLength: state.isValidLength,
                    hasUpperCase: state.hasUpperCase,
                    hasLowerCase: state.hasLowerCase,
                    hasNumberOrSymbol: state.hasNumberOrSymbol,
                  ),
                  const SizedBox(height: 32),
                  ProviderChangePasswordButton(
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
