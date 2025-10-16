import 'package:flutter/material.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/ProducerBidCardShimmer.dart';
import 'package:caterbid/modules/Producer/home/screen/widget/ProducerRequestCardShimmer.dart';

class HomeLoadingSection extends StatelessWidget {
  final double w;
  final double h;

  const HomeLoadingSection({super.key, required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: w * 0.03),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              SizedBox(height: h * 0.02),
              const ProducerRequestCardShimmer(),
              SizedBox(height: h * 0.06),
              const ProducerBidCardShimmer(),
              const ProducerBidCardShimmer(),
            ],
          ),
        ),
      ),
    );
  }
}
