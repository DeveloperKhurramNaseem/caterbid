import 'package:flutter/material.dart';
import 'ProducerBidCardShimmer.dart';

class BidsLoadingView extends StatelessWidget {
  const BidsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        ProducerBidCardShimmer(),
        SizedBox(height: 12),
        ProducerBidCardShimmer(),
      ],
    );
  }
}
