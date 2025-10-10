import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/ChangePasswordScreen/mainscreen/ChangePasswordScreen.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/OTPScreen/widgets/otp_input_fields.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/OTPScreen/widgets/otp_title_section.dart';
import 'package:caterbid/modules/auth/screens/forgetPassword/OTPScreen/widgets/otp_verify_button.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class OTPScreen extends StatefulWidget {
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

  void _onVerifyPressed() {
    final otp = _controllers.map((e) => e.text).join();
    debugPrint("OTP Entered: $otp");

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangePasswordScreen(email: widget.email),
      ),
    );
  }

  @override
  void dispose() {
    for (var c in _controllers) c.dispose();
    for (var f in _focusNodes) f.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Scaffold(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.05),
              OtpTitleSection(email: widget.email),
              SizedBox(height: h * 0.04),
              OtpInputField(controllers: _controllers, focusNodes: _focusNodes),
              SizedBox(height: h * 0.06),
              OtpVerifyButton(
                isEnabled: _isButtonEnabled,
                onPressed: _onVerifyPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
