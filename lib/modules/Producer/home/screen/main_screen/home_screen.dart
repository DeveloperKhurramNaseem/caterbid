import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/ProducerRequestCard.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/producer_appbar.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/producer_create_request_button.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/producer_empty_state.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/producerbidcard.dart';
import 'package:flutter/material.dart';
import 'package:caterbid/core/utils/responsive.dart';
import 'package:go_router/go_router.dart';

class ProducerHomeScreen extends StatelessWidget {
  static const path = '/producer_home';
  final bool? extra;

  const ProducerHomeScreen({super.key, this.extra});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    final bool hasRequest = (GoRouterState.of(context).extra as bool?) ?? false;

    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: const ProducerAppBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * 0.03),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.02),
                  if (hasRequest) ...[
                    const ProducerRequestCard(),
                    SizedBox(height: h * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Bid Received (2)",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
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
                  ] else ...{
                    SizedBox(height: h * 0.2),
                    const ProducerEmptyState(),
                    SizedBox(height: h * 0.04),
                    const ProducerCreateRequestButton(),
                  },
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
