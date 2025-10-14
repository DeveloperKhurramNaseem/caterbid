import 'dart:async';
import 'package:caterbid/modules/Producer/home/screen/main_screen/home_screen.dart';
import 'package:caterbid/modules/Restaurant/my_bids/screen/my_bids.dart';
import 'package:caterbid/modules/auth/login/screen/main_screen/login_screen.dart';
import 'package:caterbid/modules/auth/verify_email_screen/model/verify_otp_request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/core/widgets/app_logo.dart';
import 'package:caterbid/modules/auth/verify_email_screen/widgets/otp_fields.dart';
import 'package:caterbid/modules/auth/verify_email_screen/widgets/verify_button.dart';
import 'package:caterbid/modules/auth/verify_email_screen/widgets/verify_email_footer.dart';
import 'package:caterbid/modules/auth/verify_email_screen/widgets/verify_email_heading.dart';
import 'package:caterbid/modules/auth/verify_email_screen/bloc/verify_otp_bloc.dart';


class VerifyEmailScreen extends StatefulWidget {
  static const path = '/verifyemail';
  final String email;
  final String role;

  const VerifyEmailScreen({
    super.key,
    required this.email,
    required this.role,
  });

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());

  Timer? _timer;
  int _seconds = 30;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
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

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  void _resetTimer() {
    setState(() => _seconds = 30);
    _startTimer();
  }

  void _onVerifyPressed() {
    final otp = _controllers.map((e) => e.text).join();

    if (otp.length == 6) {
      final model = VerifyOtpRequestModel(
        role: widget.role,
        email: widget.email,
        otp: otp,
      );
      context.read<VerifyOtpBloc>().add(VerifyOtpButtonPressed(model));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter the 6-digit code')),
      );
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: BlocConsumer<VerifyOtpBloc, VerifyOtpState>(
          listener: (context, state) {
            if (state is VerifyOtpSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("OTP Verified Successfully!")),
              );

              context.go(LoginScreen.path);
            } else if (state is VerifyOtpFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is VerifyOtpLoading;

            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: w * 0.06),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * 0.02),
                    const Center(child: AppLogo()),
                    SizedBox(height: h * 0.06),
                    const VerifyEmailHeading(),
                    SizedBox(height: h * 0.04),
                    OTPFields(controllers: _controllers, focusNodes: _focusNodes),
                    SizedBox(height: h * 0.05),
                    isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : VerifyButton(
                            isEnabled: _isButtonEnabled,
                            onPressed: _onVerifyPressed,
                          ),
                    SizedBox(height: h * 0.03),
                    Center(
                      child: VerifyEmailFooter(
                        seconds: _seconds,
                        onResend: _resetTimer,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
