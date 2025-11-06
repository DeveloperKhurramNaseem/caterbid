import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';

class OtpTextFields extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode>? focusNodes;
  final int length;
  final double minFieldWidth;

  const OtpTextFields({
    super.key,
    required this.controllers,
    this.focusNodes,
    this.length = 6,
    this.minFieldWidth = 48,
  }) : assert(controllers.length == length, 'controllers length must equal OTP length');

  @override
  State<OtpTextFields> createState() => _OtpTextFieldsState();
}

class _OtpTextFieldsState extends State<OtpTextFields> {
  late final TextEditingController _combinedController;

  @override
  void initState() {
    super.initState();
    _combinedController = TextEditingController(
      text: widget.controllers.map((c) => c.text).join(),
    );
  }

  @override
  void didUpdateWidget(covariant OtpTextFields oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newText = widget.controllers.map((c) => c.text).join();
    if (_combinedController.text != newText) {
      _combinedController.text = newText;
    }
  }

@override
void dispose() {
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    final screenWidth = Responsive.width(context);
    final fieldWidth = (screenWidth * 0.12).clamp(widget.minFieldWidth, double.infinity);

    return SizedBox(
      width: double.infinity,
      child: PinCodeTextField(
        appContext: context,
        length: widget.length,
        controller: _combinedController,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        textStyle: TextStyle(
          fontFamily: AppFonts.nunito,
          fontWeight: FontWeight.w600,
          fontSize: Responsive.responsiveSize(context, 20, 22, 24),
          height: 1.2,
        ),
        animationType: AnimationType.none,
        enableActiveFill: false,
        showCursor: false,
        cursorWidth: 0,
        cursorColor: AppColors.c500,
        textInputAction: TextInputAction.done,
        autoDismissKeyboard: true,
        enablePinAutofill: true,

        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(8),
          fieldHeight: Responsive.responsiveSize(context, 55, 54, 60),
          fieldWidth: fieldWidth,
          activeColor: AppColors.c500,
          selectedColor: AppColors.c500,
          inactiveColor: Colors.grey.withOpacity(0.4),
          activeFillColor: Colors.transparent,
          selectedFillColor: Colors.transparent,
          inactiveFillColor: Colors.transparent,
        ),

        onChanged: (value) {
          // Keep external controllers in sync
          for (int i = 0; i < widget.controllers.length; i++) {
            final newChar = i < value.length ? value[i] : '';
            if (widget.controllers[i].text != newChar) {
              widget.controllers[i].text = newChar;
            }
          }
        },
        onCompleted: (_) => FocusScope.of(context).unfocus(),
      ),
    );
  }
}
