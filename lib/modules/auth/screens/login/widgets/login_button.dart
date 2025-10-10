import 'package:caterbid/modules/Producer/home/screen/main_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:go_router/go_router.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.c500,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        onPressed: () => context.go(ProducerHomeScreen.path),
        child: const Text(
          "Sign In",
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
