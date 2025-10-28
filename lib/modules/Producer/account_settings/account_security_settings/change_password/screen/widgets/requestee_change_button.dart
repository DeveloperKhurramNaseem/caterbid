import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/bloc/change_password_bloc.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/custom_button.dart';

class RequesteeChangePasswordButton extends StatelessWidget {
  final ChangePasswordState state;
  final VoidCallback onPressed;

  const RequesteeChangePasswordButton({
    super.key,
    required this.state,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return state.isLoading
        ? const Center(child: CircularProgressIndicator())
        : CustomButton(
            title: 'Change Password',
            isEnabled: state.isButtonEnabled,
            onPressed: onPressed,
          );
  }
}
