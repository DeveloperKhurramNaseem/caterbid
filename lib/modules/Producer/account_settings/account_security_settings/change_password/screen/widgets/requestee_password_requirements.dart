import 'package:flutter/material.dart';
import 'package:caterbid/core/widgets/password_widget/password_requirements.dart';

class RequesteePasswordRequirements extends StatelessWidget {
  final bool isValidLength;
  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasNumberOrSymbol;

  const RequesteePasswordRequirements({
    super.key,
    required this.isValidLength,
    required this.hasUpperCase,
    required this.hasLowerCase,
    required this.hasNumberOrSymbol,
  });

  @override
  Widget build(BuildContext context) {
    return PasswordRequirements(
      isValidLength: isValidLength,
      hasUpperCase: hasUpperCase,
      hasLowerCase: hasLowerCase,
      hasNumberOrSymbol: hasNumberOrSymbol,
    );
  }
}
