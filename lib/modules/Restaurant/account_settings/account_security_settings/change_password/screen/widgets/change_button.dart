import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import '../../bloc/provider_change_password_bloc.dart';

class ProviderChangePasswordButton extends StatelessWidget {
  final ProviderChangePasswordState state;
  final VoidCallback onPressed;

  const ProviderChangePasswordButton({
    super.key,
    required this.state,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: state.isButtonEnabled ? AppColors.c500 : AppColors.c300,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        onPressed: state.isButtonEnabled ? onPressed : null, // ✅ disable when false
        child: Text(
          "Change",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
