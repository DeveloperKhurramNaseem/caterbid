import 'package:caterbid/core/widgets/custom_button.dart';
import 'package:caterbid/modules/Producer/home/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Restaurant/business_profile/main_screen/set_business_profile_screen.dart';
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Welcome ${user.email}!')));

          if (user.role == 'requestee') {
            context.go(ProducerHomeScreen.path);
          } else if (user.role == 'provider') {
            if (user.locationRequired == true){
              context.go(SetBusinessProfileScreen.path);
            }else if (user.locationRequired == false){
            context.go(MyBidsScreen.path);

            }
          }
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        final isLoading = state is LoginLoading;

        return CustomButton(
          title: "Login",
          isEnabled: !isLoading, 
          onPressed: () {
            if (formKey.currentState!.validate()) {
              final model = LoginRequestModel(
                email: emailController.text.trim(),
                password: passwordController.text.trim(),
              );
              context.read<LoginBloc>().add(LoginButtonPressed(model));
            }
          },
        );
      },
    );
  }
}
