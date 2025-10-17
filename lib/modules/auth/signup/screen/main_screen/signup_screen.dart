import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/widgets/app_logo.dart';
import 'package:caterbid/core/widgets/loader_overlay.dart';
import 'package:caterbid/modules/auth/signup/bloc/sign_up_bloc.dart';
import 'package:caterbid/modules/auth/signup/bloc/sign_up_state.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/signup_footer.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/signup_form.dart';
import 'package:caterbid/modules/auth/signup/screen/widget/signup_heading.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  static const path = '/';
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return BlocBuilder<SignUpBloc, SignUpState>(
      builder: (context, state) {
        final isLoading = state is SignUpLoading;

        return LoaderOverlay(
          isLoading: isLoading,
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: AppColors.appBackground,
              appBar: AppLogoAppBar(),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 400),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: h * 0.02),
                          const SignUpHeading(),
                          SizedBox(height: h * 0.03),
                          const SignUpForm(),
                          SizedBox(height: h * 0.03),
                          const SignUpFooter(),
                          SizedBox(height: h * 0.05),
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
