import 'dart:async';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class ResendOtpWidget extends StatefulWidget {
  final VoidCallback onResend;

  const ResendOtpWidget({
    super.key,
    required this.onResend,
  });

  @override
  State<ResendOtpWidget> createState() => _ResendOtpWidgetState();
}

class _ResendOtpWidgetState extends State<ResendOtpWidget> {
  Timer? _timer;
  int _seconds = 60; // 1 minute

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _seconds = 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() => _seconds--);
      } else {
        _timer?.cancel();
      }
    });
  }

  void _onResendPressed() {
    widget.onResend();
    _startTimer(); // restart 1-minute timer
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          _seconds > 0
              ? "Resend code in $_seconds seconds"
              : "Didn’t receive the code?",
          style: TextStyle(
            fontSize: w * 0.035,
            color: Colors.grey[600],
          ),
        ),
        if (_seconds == 0)
          TextButton(
            onPressed: _onResendPressed,
            child: Text(
              "Resend OTP",
              style: TextStyle(
                color: AppColors.c500,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}
