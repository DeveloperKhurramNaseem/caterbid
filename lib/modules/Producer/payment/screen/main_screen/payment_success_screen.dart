import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/ui/responsive.dart';
import 'package:flutter/material.dart';
import '../widgets/success_icon.dart';
import '../widgets/payment_info_card.dart';
import '../widgets/done_button.dart';

class PaymentSuccessScreen extends StatelessWidget {
  static const path = '/PaymentSuccessScreen';

  const PaymentSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // final w = Responsive.width(context);
    final h = Responsive.height(context);

    final double verticalSpace = Responsive.responsiveSize(context, 20, 30, 40);

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: Responsive.responsiveSize(context, 20, 40, 80),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: verticalSpace),
            const SuccessIcon(),
            SizedBox(height: verticalSpace),
            Text(
              "Payment Successful",
              style: TextStyle(
                fontFamily: AppFonts.poppins,
                fontSize: Responsive.responsiveSize(context, 22, 26, 30),
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Your payment has been completed successfully.",
              style: TextStyle(
                color: Colors.grey,
                fontFamily: AppFonts.poppins,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: verticalSpace),
            Text(
              "Amount",
              style: TextStyle(
                fontFamily: AppFonts.nunito,
                fontWeight: FontWeight.w500,
                fontSize: Responsive.responsiveSize(context, 16, 18, 20),
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "\$206.5",
              style: TextStyle(
                fontFamily: AppFonts.nunito,
                fontSize: Responsive.responsiveSize(context, 26, 30, 34),
                fontWeight: FontWeight.w700,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              "22 sep 2025 Bill ID:#BILL1234",
              style: TextStyle(
                color: Colors.grey,
                fontFamily: AppFonts.nunito,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: verticalSpace),
            const PaymentInfoCard(),

            SizedBox(height: h * 0.07),
            const DoneButton(),
            SizedBox(height: verticalSpace),
          ],
        ),
      ),
    );
  }
}
