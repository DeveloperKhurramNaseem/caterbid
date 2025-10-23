import 'package:caterbid/modules/Producer/home/active_request_bid/model/producer_bid_model.dart';
import 'package:flutter/material.dart';
import 'producerbidcard.dart';

class BidsLoadedView extends StatelessWidget {
  final List<BidModel> bids;
  final double maxWidth;

  const BidsLoadedView({super.key, required this.bids, required this.maxWidth});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth < 500 ? maxWidth : 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bids Received (${bids.length})",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 12),
          ...bids.map(
            (bid) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProducerBidCard(
                imageUrl: bid.attachment != null && bid.attachment!.isNotEmpty
                    ? "https://api.cater-bid.com${bid.attachment}"
                    : "https://picsum.photos/200",
                name: bid.provider.companyName,
                price:
                    "\$${bid.amountDollars} / ${bid.request.numPeople} people",
                location: "San Francisco, CA",
                date: bid.request.date.toString(),
                description: bid.description ?? 'No description available',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
