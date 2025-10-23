import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:flutter/material.dart';

class PasswordRequirements extends StatelessWidget {
  final bool isValidLength;
  final bool hasUpperCase;
  final bool hasLowerCase;
  final bool hasNumberOrSymbol;

  const PasswordRequirements({
    super.key,
    required this.isValidLength,
    required this.hasUpperCase,
    required this.hasLowerCase,
    required this.hasNumberOrSymbol,
  });

  Widget _buildRequirement(String text, bool isValid) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 10,
          color: isValid ? AppColors.password : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: TextStyle(
            color: isValid ? AppColors.password : Colors.grey,
            fontSize: 13,

            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Password must contain",
          style: TextStyle(
            fontSize: 16,
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        _buildRequirement("At least 8 characters", isValidLength),
        _buildRequirement("At least one capital letter", hasUpperCase),
        _buildRequirement("At least one small letter", hasLowerCase),
        _buildRequirement(
          "Contain a number or symbol (e.g. #, ?, !, &)",
          hasNumberOrSymbol,
        ),
      ],
    );
  }
}
