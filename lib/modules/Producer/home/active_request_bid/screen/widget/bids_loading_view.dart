import 'package:caterbid/core/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'ProducerBidCardShimmer.dart';

class BidsLoadingView extends StatelessWidget {
  const BidsLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final w = Responsive.width(context);
    final h = Responsive.height(context);

    return Column(
      children: [
        SizedBox(height: h * 0.04),

        ProducerBidCardShimmer(),
        ProducerBidCardShimmer(),
      ],
    );
  }
}
