import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Producer/home/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Restaurant/home/main_screen/bids_home.dart';
import 'package:caterbid/modules/auth/login/bloc/login_bloc.dart';
import 'package:caterbid/modules/auth/login/model/login_request_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginButton extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey;

  const LoginButton({
    super.key,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          final user = state.user;
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Welcome ${user.email}!')));

          if (user.role == 'requestee') {
            context.go(ProducerHomeScreen.path);
          } else if (user.role == 'provider') {
            context.go(MyBidsScreen.path);
          }
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        if (state is LoginLoading) {
          return const Center(child: CircularProgressIndicator());
        }

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
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final model = LoginRequestModel(
                  email: emailController.text.trim(),
                  password: passwordController.text.trim(),
                );
                context.read<LoginBloc>().add(LoginButtonPressed(model));
              }
            },
            child: const Text(
              "Sign In",
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
