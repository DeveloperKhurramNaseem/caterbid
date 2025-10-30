import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/utils/helpers/formatted_date.dart';
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
          ...bids.map((bid) {
            final bidDate = DateFormatter.fullDateTime(bid.createdAt);

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProducerBidCard(
                attachmentImageUrl: bid.attachmentUrl,
                profileImageUrl: bid.providerProfileUrl,
                name: bid.provider.companyName,
                price:
                    "\$${bid.amountDollars} / ${bid.request.numPeople} people",
                location: "San Francisco, CA",
                date: bidDate,
                description: bid.description,
              ),
            );
          }),
        ],
      ),
    );
  }
}
