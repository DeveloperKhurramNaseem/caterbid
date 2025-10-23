import 'package:caterbid/core/widgets/otp_text_fields.dart';
import 'package:flutter/material.dart';


class OtpInputField extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final double minFieldWidth;

  const OtpInputField({
    super.key,
    required this.controllers,
    required this.focusNodes,
    this.minFieldWidth = 48,
  }) : assert(controllers.length == focusNodes.length, 'controllers and focusNodes lengths must match');

  @override
  Widget build(BuildContext context) {
    return OtpTextFields(
      controllers: controllers,
      length: controllers.length,
      minFieldWidth: minFieldWidth,
    );
  }
}
