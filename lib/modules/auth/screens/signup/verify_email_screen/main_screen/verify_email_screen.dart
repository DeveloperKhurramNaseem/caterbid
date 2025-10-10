import 'dart:async';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/auth/screens/signup/verify_email_screen/widgets/otp_fields.dart';
import 'package:caterbid/modules/auth/screens/signup/verify_email_screen/widgets/verify_button.dart';
import 'package:caterbid/modules/auth/screens/signup/verify_email_screen/widgets/verify_email_footer.dart';
import 'package:caterbid/modules/auth/screens/signup/verify_email_screen/widgets/verify_email_heading.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/app_logo.dart';
import 'package:caterbid/core/utils/responsive.dart';

class VerifyEmailScreen extends StatefulWidget {
  static const path = '/verifyemail';
  const VerifyEmailScreen({super.key});

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
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
      debugPrint("OTP Entered: $otp");
      // TODO: Add backend verify logic
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
        child: SingleChildScrollView(
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
                VerifyButton(
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
        ),
      ),
    );
  }
}
