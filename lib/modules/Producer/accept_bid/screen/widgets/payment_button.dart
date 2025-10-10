import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:caterbid/modules/Producer/payment/screen/main_screen/payment_success_screen.dart';

class PaymentButton extends StatelessWidget {
  const PaymentButton({super.key});

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
        onPressed: () {
          context.push(PaymentSuccessScreen.path);
                },
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
