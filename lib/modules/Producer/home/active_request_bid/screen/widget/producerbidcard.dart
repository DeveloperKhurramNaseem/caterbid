import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/config/app_constants.dart';
import 'package:caterbid/modules/Producer/accept_bid/screen/main_screen/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class ProducerBidCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String price;
  final String location;
  final String date;
  final String description;

  const ProducerBidCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.price,
    required this.location,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Container(
      margin: EdgeInsets.only(bottom: h * 0.015),
      padding: EdgeInsets.all(w * 0.035),
      decoration: BoxDecoration(
        color: AppColors.cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: h * 0.08,
                  width: h * 0.08,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(width: w * 0.03),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: w * 0.04,
                      ),
                    ),
                    Text(
                      price,
                      style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.w600,
                        fontSize: w * 0.035,
                      ),
                    ),
                    Text(location, style: TextStyle(fontSize: w * 0.033)),
                    Text(date, style: TextStyle(fontSize: w * 0.033)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: h * 0.01),
          Text(description, style: TextStyle(fontSize: w * 0.034)),
          SizedBox(height: h * 0.012),
          GestureDetector(
            onTap: () {
              
            },
            child: Text(
              "See attached menu 📎",
              style: TextStyle(
                color: Colors.teal,
                fontWeight: FontWeight.w500,
                fontSize: w * 0.035,
              ),
            ),
          ),
          SizedBox(height: h * 0.015),
          SizedBox(
            width: double.infinity,
            height: h * 0.055,
            child: ElevatedButton(
              onPressed: () {
                context.push(PaymentScreen.path);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Accept Bid",
                style: TextStyle(
                  fontFamily: AppFonts.nunito,
                  color: Colors.white,
                  fontSize: w * 0.037,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
