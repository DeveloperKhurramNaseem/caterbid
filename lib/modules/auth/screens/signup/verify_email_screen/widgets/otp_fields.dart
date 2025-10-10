import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class OTPFields extends StatefulWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  const OTPFields({
    super.key,
    required this.controllers,
    required this.focusNodes,
  });

  @override
  State<OTPFields> createState() => _OTPFieldsState();
}

class _OTPFieldsState extends State<OTPFields> {
  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        return SizedBox(
          width: w * 0.12,
          child: TextField(
            controller: widget.controllers[index],
            focusNode: widget.focusNodes[index],
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(1),
            ],
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppFonts.nunito,
              fontWeight: FontWeight.w600,
              fontSize: Responsive.responsiveSize(context, 20, 22, 24),
            ),
            decoration: InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: widget.controllers[index].text.isNotEmpty
                      ? AppColors.c500
                      : Colors.grey,
                  width: 1.2,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.c500, width: 1.6),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              setState(() {});
              if (value.isNotEmpty) {
                if (index < 5) {
                  FocusScope.of(
                    context,
                  ).requestFocus(widget.focusNodes[index + 1]);
                } else {
                  FocusScope.of(context).unfocus();
                }
              } else if (value.isEmpty && index > 0) {
                FocusScope.of(
                  context,
                ).requestFocus(widget.focusNodes[index - 1]);
              }
            },
          ),
        );
      }),
    );
  }
}
