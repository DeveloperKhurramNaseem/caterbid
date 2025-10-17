import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/loader_overlay.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/main_screen/OTPScreen.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/bloc/forget_password_bloc.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/model/forget_password_request.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/screen/widgets/forget_password_button.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/screen/widgets/forget_password_form.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/screen/widgets/forget_password_title_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const path = '/forget-password';
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccess) {
          context.go(OTPScreen.path, extra: {'email': state.email});
        } else if (state is ForgetPasswordFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final isLoading = state is ForgetPasswordLoading;

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
            body: SafeArea(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 400),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.05),
                        const ForgetPasswordTitleSection(),
                        SizedBox(height: h * 0.05),
                        ForgetPasswordForm(emailController: _emailController),
                        SizedBox(height: h * 0.06),
                        ForgetPasswordButton(
                          emailController: _emailController,
                          onPressed: () {
                            final email = _emailController.text.trim();
                            if (email.isNotEmpty) {
                              final request = ForgetPasswordRequest(
                                email: email,
                              );
                              context.read<ForgetPasswordBloc>().add(
                                SubmitForgetPasswordEmail(request),
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Enter your email"),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
