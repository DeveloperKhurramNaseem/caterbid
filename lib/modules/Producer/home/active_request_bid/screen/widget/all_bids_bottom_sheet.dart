import 'package:flutter/material.dart';
import 'producerbidcard.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/model/formatted_bid_model.dart';

class AllBidsBottomSheet extends StatelessWidget {
  final List<FormattedBidModel> bids;

  const AllBidsBottomSheet({super.key, required this.bids});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (_, controller) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Handle
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Header
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "All Bids",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1),
              // List of bids
              Expanded(
                child: ListView.builder(
                  controller: controller,
                  padding: const EdgeInsets.all(16),
                  itemCount: bids.length,
                  itemBuilder: (context, index) {
                    final bid = bids[index];

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: ProducerBidCard(bid: bid),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
