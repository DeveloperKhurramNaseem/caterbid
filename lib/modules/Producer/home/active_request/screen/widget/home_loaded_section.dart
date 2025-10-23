import 'package:flutter/material.dart';
import 'package:caterbid/modules/Producer/home/active_request/screen/widget/ProducerRequestCard.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/screen/main_screen/bids_section.dart';

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
    final request = requests.first;

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * 0.02),


              ProducerRequestCard(request: request),

              SizedBox(height: h * 0.03),

              BidsSection(requestId: request.id),
            ],
          ),
        ),
      ),
    );
  }
}
