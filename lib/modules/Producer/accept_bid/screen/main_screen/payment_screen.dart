import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:caterbid/modules/Producer/accept_bid/model/payment_model.dart';
import 'package:flutter/material.dart';
import '../widgets/payment_header.dart';
import '../widgets/payment_details.dart';
import '../widgets/payment_button.dart';

class PaymentScreen extends StatelessWidget {
  static const path = '/payment';
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    final payment = PaymentModel(
      title: "Dinner for Film Crew",
      location: "Hollywood, CA",
      date: "Sept 6, 2024 , 1:30 pm",
      subtotal: 200,
      platformFee: 6.5,
    );

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.06),
          child: Column(
            children: [
              SizedBox(height: h * 0.04),
              const PaymentHeader(),
              SizedBox(height: h * 0.04),
              PaymentDetails(payment: payment),
              const Spacer(),
              const PaymentButton(),
              SizedBox(height: h * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
