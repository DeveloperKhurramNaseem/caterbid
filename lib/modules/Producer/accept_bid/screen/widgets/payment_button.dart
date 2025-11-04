import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';

class PaymentButton extends StatelessWidget {
  final VoidCallback? onPressed;

  const PaymentButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    final w = Responsive.width(context);

    return SizedBox(
      width: w,
      height: h * 0.065,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: onPressed,
        child: const Text(
          "Pay",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}
