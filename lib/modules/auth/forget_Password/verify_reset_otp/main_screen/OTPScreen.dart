import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/screen/mainscreen/ChangePasswordScreen.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/bloc/verify_reset_otp_bloc.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/model/verify_otp_request.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/repository/verify_otp_repository.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/widgets/otp_input_fields.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/widgets/otp_title_section.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/widgets/otp_verify_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OTPScreen extends StatefulWidget {
  static const path = '/otp_screen';
  final String email;
  const OTPScreen({super.key, required this.email});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    for (var controller in _controllers) {
      controller.addListener(_checkFieldsFilled);
    }
  }

  void _checkFieldsFilled() {
    final allFilled = _controllers.every((c) => c.text.isNotEmpty);
    if (allFilled != _isButtonEnabled) {
      setState(() => _isButtonEnabled = allFilled);
    }
  }

  void _onVerifyPressed(BuildContext context) {
    final otp = _controllers.map((e) => e.text).join();

    final request = VerifyOtpRequest(email: widget.email, otp: otp);

    context.read<VerifyResetOtpBloc>().add(SubmitOtpEvent(request));
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return BlocProvider(
      create: (context) => VerifyResetOtpBloc(VerifyOtpRepository()),
      child: BlocListener<VerifyResetOtpBloc, VerifyResetOtpState>(
        listener: (context, state) {
          if (state is VerifyOtpLoading) {
            // ScaffoldMessenger.of(
            //   context,
            // ).showSnackBar(const SnackBar(content: Text("Verifying OTP...")));
          } else if (state is VerifyOtpSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("OTP verified successfully")),
            );
            context.go(
              ChangePasswordScreen.path,
              extra: {'email': state.email},
            );
          } else if (state is VerifyOtpFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Scaffold(
          backgroundColor: AppColors.appBackground,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: true,
            iconTheme: const IconThemeData(color: Colors.black),
          ),
          body: SafeArea(
            child: BlocBuilder<VerifyResetOtpBloc, VerifyResetOtpState>(
              builder: (context, state) {
                final isLoading = state is VerifyOtpLoading;
                return AbsorbPointer(
                  absorbing: isLoading,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: w * 0.06),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: h * 0.05),
                        OtpTitleSection(email: widget.email),
                        SizedBox(height: h * 0.04),
                        OtpInputField(
                          controllers: _controllers,
                          focusNodes: _focusNodes,
                        ),
                        SizedBox(height: h * 0.06),
                        OtpVerifyButton(
                          isEnabled: _isButtonEnabled && !isLoading,
                          onPressed: () => _onVerifyPressed(context),
                        ),
                        if (isLoading)
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: CircularProgressIndicator(
                                color: AppColors.c500,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
