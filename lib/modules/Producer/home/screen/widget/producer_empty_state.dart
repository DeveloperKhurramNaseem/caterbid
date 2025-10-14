import 'package:caterbid/modules/Producer/home/screen/widget/producer_create_request_button.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/core/utils/responsive.dart';

class ProducerEmptyState extends StatelessWidget {
  const ProducerEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final h = Responsive.height(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: Responsive.responsiveSize(context, 50, 70, 100),
          backgroundColor: Colors.grey,
        ),
        SizedBox(height: h * 0.02),
        Text(
          'No Bids Yet',
          style: TextStyle(
            fontFamily: AppFonts.nunito,
            fontSize: Responsive.responsiveSize(context, 23, 28, 32),
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: h * 0.01),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.responsiveSize(context, 20, 30, 40),
          ),
          child: Column(
            children: [
              Text(
                "You haven't created any catering requests yet. Once you do, restaurants, caterers, and event managers will send you their bids.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: AppFonts.nunito,
                  fontWeight: FontWeight.w600,
                  fontSize: Responsive.responsiveSize(context, 14, 16, 18),
                ),
              ),
                      SizedBox(height: h * 0.03),
        const ProducerCreateRequestButton(),
            ],
          ),
        ),
      ],
    );
  }
}
