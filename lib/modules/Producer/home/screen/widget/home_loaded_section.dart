import 'package:flutter/material.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/producerbidcard.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/ProducerRequestCard.dart';

class HomeLoadedSection extends StatelessWidget {
  final List requests;
  final double w;
  final double h;

  const HomeLoadedSection({
    super.key,
    required this.requests,
    required this.w,
    required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.02),
              ProducerRequestCard(request: requests.first),
              SizedBox(height: h * 0.03),

              /// --- Header ---
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "Bid Received (2)",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    "View all",
                    style: TextStyle(
                      color: Colors.teal,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.02),

              /// --- Bids List ---
              const ProducerBidCard(
                imageUrl: "https://picsum.photos/100",
                name: "Restaurant 1",
                price: "\$200 / 50 people",
                location: "Hollywood, CA",
                date: "Sept 6, 2024 at 1:30 pm",
                description:
                    "We specialize in sandwiches, salads, and wraps, perfect for a film crew. We can accommodate dietary restrictions.",
              ),
              SizedBox(height: h * 0.02),
              const ProducerBidCard(
                imageUrl: "https://picsum.photos/101",
                name: "Caterer Crew",
                price: "\$200 / 50 people",
                location: "Hollywood, CA",
                date: "Sept 6, 2024 at 1:30 pm",
                description:
                    "We specialize in sandwiches, salads, and wraps, perfect for a film crew.",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
