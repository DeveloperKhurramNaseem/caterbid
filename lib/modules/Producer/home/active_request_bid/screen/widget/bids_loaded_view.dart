import 'package:flutter/material.dart';
import 'producerbidcard.dart';
import 'all_bids_bottom_sheet.dart';
import 'package:caterbid/core/utils/helpers/formatter/formatted_date.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/model/formatted_bid_model.dart';

class BidsLoadedView extends StatelessWidget {
  final List<FormattedBidModel> bids;
  final double maxWidth;

  const BidsLoadedView({super.key, required this.bids, required this.maxWidth});

  void _openAllBidsSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => AllBidsBottomSheet(bids: bids),
    );
  }

  @override
  Widget build(BuildContext context) {
    final latestBids = bids.length > 2 ? bids.sublist(0, 2) : bids;

    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: maxWidth < 500 ? maxWidth : 500),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with "Bids Received" and "View All"
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Bids Received (${bids.length})",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              if (bids.length > 2)
                TextButton(
                  onPressed: () => _openAllBidsSheet(context),
                  child: const Text("View All"),
                ),
            ],
          ),
          const SizedBox(height: 12),
          // Latest 2 bids
          ...latestBids.map((bid) {
            final bidDate = DateFormatter.fullDateTime(bid.createdAt);
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ProducerBidCard(bid: bid,
              ),
            );
          }),
        ],
      ),
    );
  }
}
