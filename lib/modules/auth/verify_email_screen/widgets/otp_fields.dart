import 'package:caterbid/core/widgets/otp_text_fields.dart';
import 'package:flutter/material.dart';



class OTPFieldsPackage extends StatelessWidget {
  final List<TextEditingController> controllers;
  final int length;
  final double minFieldWidth;

  const OTPFieldsPackage({
    super.key,
    required this.controllers,
    this.length = 6,
    this.minFieldWidth = 48,
  }) : assert(controllers.length == length, 'controllers length must equal OTP length');

  @override
  Widget build(BuildContext context) {
    return OtpTextFields(
      controllers: controllers,
      length: length,
      minFieldWidth: minFieldWidth,
    );
  }
}
