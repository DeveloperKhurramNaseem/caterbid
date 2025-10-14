import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class ContactNumberField extends StatefulWidget {
  final TextEditingController? controller;
  final Function(String fullNumber)? onChanged;

  const ContactNumberField({
    super.key,
    this.controller,
    this.onChanged,
  });

  @override
  State<ContactNumberField> createState() => _ContactNumberFieldState();
}

class _ContactNumberFieldState extends State<ContactNumberField> {
  String? phoneNumber;
  String? countryCode = "+1"; 
  bool isValid = true;

  void _validateNumber(String number) {
    final cleanNumber = number.replaceAll(RegExp(r'[^0-9]'), '');
    
    if (countryCode == "+1" && !RegExp(r'^[0-9]{10}$').hasMatch(cleanNumber)) {
      isValid = false;
    } else {
      isValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = Responsive.responsiveSize(context, 12, 15, 18);
    final fontSize = Responsive.responsiveSize(context, 14, 16, 18);
    final verticalPadding = Responsive.responsiveSize(context, 12, 16, 18);
    final horizontalPadding = Responsive.responsiveSize(context, 12, 16, 20);

    return Theme(
      data: Theme.of(context).copyWith(
        inputDecorationTheme: const InputDecorationTheme(
          errorStyle: TextStyle(height: 0), 
        ),
      ),
      child: IntlPhoneField(
        controller: widget.controller,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        showDropdownIcon: true,
        dropdownIconPosition: IconPosition.trailing,
        dropdownIcon: const Icon(Icons.arrow_drop_down, color: AppColors.textDark),
        flagsButtonPadding: const EdgeInsets.only(left: 10),
        disableLengthCheck: true,
        cursorColor: AppColors.textDark,
        initialCountryCode: 'US', // Set to US for +1
        validator: (phone) {
          _validateNumber(phone?.number ?? '');
          return isValid ? null : "Please enter a valid 10-digit number";
        },
        decoration: InputDecoration(
          labelText: 'Contact Number',
          labelStyle: TextStyle(
            color: AppColors.textDark,
            fontFamily: AppFonts.nunito,
            fontWeight: FontWeight.w600,
            fontSize: fontSize,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.grey.withOpacity(0.3), width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(width: 1.5, color: AppColors.c500),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(width: 1.5, color: Colors.redAccent),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(width: 1.5, color: Colors.redAccent),
          ),
          contentPadding: EdgeInsets.symmetric(
            vertical: verticalPadding,
            horizontal: horizontalPadding,
          ),
        ),
        onChanged: (PhoneNumber phone) {
          setState(() {
            phoneNumber = phone.number;
            countryCode = phone.countryCode;
            _validateNumber(phone.number);
          });
          // Cleaning number as api expecting without +, simple number)
          final cleanNumber = phone.number.replaceAll(RegExp(r'[^0-9]'), '');
          widget.onChanged?.call(cleanNumber);
        },
        onCountryChanged: (country) {
          setState(() => countryCode = "+${country.dialCode}");
        },
      ),
    );
  }
}