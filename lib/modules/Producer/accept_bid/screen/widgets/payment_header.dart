import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter/material.dart';

class PaymentHeader extends StatelessWidget {
  const PaymentHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);
    return Center(
      child: ImageIcon(
        AssetImage("assets/icons/payment_bag.png"),
        color: Colors.teal,
        size: h * 0.18,
      ),
    );
  }
}
